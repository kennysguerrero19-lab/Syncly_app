const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const Project = require('../models/Project');

// GET all projects for current user (owned or member)
router.get('/', auth, async (req, res) => {
  try {
    const projects = await Project.find({ $or: [{ owner: req.user.id }, { members: req.user.id }] }).populate('owner', 'name email');
    res.json(projects);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// POST create project
router.post('/', auth, async (req, res) => {
  const { title, description, members } = req.body;
  if (!title) return res.status(400).json({ msg: 'Title is required' });
  try {
    const project = new Project({ title, description, owner: req.user.id, members: members || [] });
    await project.save();
    res.json(project);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// GET project by id
router.get('/:id', auth, async (req, res) => {
  try {
    const project = await Project.findById(req.params.id).populate('owner', 'name email');
    if (!project) return res.status(404).json({ msg: 'Project not found' });
    res.json(project);
  } catch (err) {
    console.error(err.message);
    if (err.kind === 'ObjectId') return res.status(404).json({ msg: 'Project not found' });
    res.status(500).send('Server error');
  }
});

// PUT update project
router.put('/:id', auth, async (req, res) => {
  const { title, description, members } = req.body;
  const update = {};
  if (title) update.title = title;
  if (description) update.description = description;
  if (members) update.members = members;
  try {
    let project = await Project.findById(req.params.id);
    if (!project) return res.status(404).json({ msg: 'Project not found' });
    // Only owner can update
    if (project.owner.toString() !== req.user.id) return res.status(403).json({ msg: 'Forbidden' });
    project = await Project.findByIdAndUpdate(req.params.id, { $set: update }, { new: true });
    res.json(project);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// DELETE project
router.delete('/:id', auth, async (req, res) => {
  try {
    const project = await Project.findById(req.params.id);
    if (!project) return res.status(404).json({ msg: 'Project not found' });
    if (project.owner.toString() !== req.user.id) return res.status(403).json({ msg: 'Forbidden' });
    await project.remove();
    res.json({ msg: 'Project removed' });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

module.exports = router;
