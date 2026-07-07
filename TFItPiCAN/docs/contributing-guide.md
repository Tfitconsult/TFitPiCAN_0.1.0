# Contributing to TFitPiCAN

- **Author:** Thomas Fischer
- **Version:** 0.1.0
- **Filename:** CONTRIBUTING.md
- **Filetype:** Markdown
- **Description:** Guidelines for contributing to the TFitPiCAN project

## Welcome!

Thank you for considering contributing to TFitPiCAN! This document provides guidelines and steps for contributing to the project.

## Code of Conduct

By participating in this project, you agree to uphold our Code of Conduct:

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to see if the problem has already been reported. When creating a bug report, include as many details as possible:

- Use a clear and descriptive title
- Describe the exact steps to reproduce the problem
- Describe the behavior you observed after following the steps
- Explain which behavior you expected to see instead
- Include screenshots if applicable
- Include details about your environment:
  - OS and version
  - Python version
  - Hardware configuration (especially for Raspberry Pi)

### Suggesting Enhancements

Enhancement suggestions are welcome. When creating an enhancement suggestion:

- Use a clear and descriptive title
- Provide a step-by-step description of the enhancement
- Describe the current behavior and explain which behavior you expected to see instead
- Explain why this enhancement would be useful to most users

### Code Contributions

#### Setting Up Your Development Environment

1. Fork the repository
2. Clone your fork locally:
   ```bash
   git clone https://github.com/your-username/TFitPiCAN.git
   cd TFitPiCAN
   ```
3. Create a virtual environment and install dependencies:
   ```bash
   python venv_setup.py
   ```
4. Activate the virtual environment:
   - Windows: `venv\Scripts\activate`
   - macOS/Linux: `source venv/bin/activate`

#### Creating a Branch

Create a new branch for your changes:
```bash
git checkout -b feature/your-feature-name
```

Use descriptive branch names like:
- `feature/add-emergency-brake-scenario`
- `bugfix/can-timeout-handling`
- `docs/improve-class-documentation`

#### Making Changes

1. Make your changes with your preferred editor
2. Follow the coding style guidelines (see below)
3. Add or update tests as necessary
4. Add or update documentation as necessary
5. Run the existing tests to ensure you haven't broken anything:
   ```bash
   python -m src.test_library
   ```

#### Code Style Guidelines

- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) for Python code
- Use 4 spaces for indentation (not tabs)
- Maximum line length of 100 characters
- Add docstrings to all classes and functions (following [Google style](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings))
- Use meaningful variable and function names
- Keep functions focused on a single responsibility

#### Commit Message Guidelines

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests in the body
- When only changing documentation, include `[ci skip]` in the commit title

Example commit message:
```
Add emergency brake scenario

- Implements new scenario for emergency braking simulation
- Updates scenario selection UI to include new scenario
- Adds tests for the new scenario

Fixes #42
```

#### Submitting a Pull Request

1. Push your changes to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
2. Submit a pull request to the main repository
3. Title the pull request with a short description of the changes
4. In the description, explain your changes and reference any related issues
5. If your PR fixes an open issue, add "Fixes #issue-number" to the PR description

#### Pull Request Review Process

1. Other contributors will review your PR
2. They may ask for changes
3. Address any requested changes and push them to your branch
4. Once approved, a maintainer will merge your PR

## Documentation

Good documentation is crucial for this project. When contributing:

1. Update the README.md if needed
2. Update or create class documentation in the docs/classes/ directory
3. Update UML diagrams if your changes affect the system structure
4. Ensure YAML examples reflect your changes if applicable
5. Add comments to complex code sections

## File Headers

All source files should include a header:

```python
"""
Author: Thomas Fischer
Version: 0.1.0
Filename: your_file.py
Description: Brief description of the file

Copyright (c) 2025 Thomas Fischer
"""
```

For YAML files, include a meta block:

```yaml
meta:
  author: "Thomas Fischer"
  version: "0.1.0"
  description: "Description of the YAML file"
```

## Adding New Classes

When adding a new class:

1. Create the class file in the appropriate package directory
2. Create a test file in the tests directory
3. Create documentation in the docs/classes directory
4. Update UML diagrams if needed
5. Register the class in any relevant manager classes

## Adding New Scenarios

To add a new scenario:

1. Create a new class extending the `Scenario` base class
2. Create a YAML configuration file in the scenarios/ directory
3. Add unit tests for the scenario
4. Update documentation to include the new scenario

## Questions?

If you have any questions or need help, please:

1. Check existing issues and discussions
2. Open a new issue with your question
3. Contact the maintainers via email

Thank you for contributing to TFitPiCAN!
