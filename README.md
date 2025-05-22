📘 Ruby Documentation – Beginner Guide
This document provides a clear and concise overview of basic Ruby concepts including syntax, conditionals, loops, input/output, file execution, and Git workflow. All your learning details will be structured and centralized here so that you can continue to add content as you progress in the bootcamp.
🖥️ Installation Guide
🔧 Install Ruby & IRB
Windows:
Install Ruby from https://rubyinstaller.org.
During the setup process, make sure to select the option "Add Ruby to PATH" to allow Ruby commands to be run from any directory in your terminal.
IRB (Interactive Ruby) is automatically included with the RubyInstaller.
Git is a version control system essential for managing your code.

Windows: Download the installer from the official Git website: https://git-scm.com. Follow the installation prompts.
✅ Verify Installations
After installation, you can verify that Ruby, IRB, and Git are correctly installed by running these commands in your terminal:
Verify Ruby Version:
ruby -v


Launch IRB:
irb

To exit IRB, type exit and press Enter.
Verify Git Version:
git --version


⚡ Quick Reference Table for Installation
Here's a quick summary of the installation commands for different operating systems:


Tool
Windows Installation
Linux (Debian/Ubuntu) Installation
Ruby & IRB
RubyInstaller from https://rubyinstaller.org (select "Add Ruby to PATH")
sudo apt install ruby-full
Git
Git for Windows installer from https://git-scm.com
sudo apt install git
GCC & Make
MSYS2 (run pacman commands in MSYS2 terminal)
sudo apt install build-essential

🚀 Project Setup Guide
This section guides you through setting up a new Ruby project using Git.
1. Clone Repository (if starting from an existing project):
If you have an existing project on GitHub (or another Git hosting service), you can clone it to your local machine:
git clone <repo-url>
cd Ruby_On_Rails # Replace 'Ruby_On_Rails' with your repository's directory name


2. Initialize Git (if starting a new project locally):
If you're starting a brand new project on your computer, you'll want to initialize a Git repository in your project folder:
git init
git checkout -b your-branch-name # Create and switch to a new development branch


3. Run Ruby Files:
Once your project is set up, you can run individual Ruby files from your terminal:
ruby File_name.rb # Replace 'File_name.rb' with the actual name of your Ruby file


✍️ Writing and Running Ruby Scripts
Create a file: You'll typically create Ruby script files with a .rb extension, for example, hello.rb or personal.rb.
Run from Terminal: To execute your Ruby script, navigate to its directory in your terminal and use the ruby command:
ruby hello.rb


Common File Example: A very basic Ruby script to display text on the console:
# hello.rb
puts "Hello, world!"


🛠 Git & GitHub Workflow
This section outlines a basic workflow for using Git and GitHub to manage your Ruby projects.
Initialize Git Repository:
To start tracking changes in your project folder, navigate to your project's root directory in the terminal and initialize a Git repository:
git init


Create a Branch:
It's good practice to work on a separate branch for new features or changes, rather than directly on the main or master branch.
git checkout -b personal-info # Creates a new branch named 'personal-info' and switches to it


Add Files and Commit:
After making changes to your files, you need to "stage" them (add them to the staging area) and then "commit" them (save a snapshot of your changes to the repository's history).
git add . # Stages all changes in the current directory and its subdirectories
git commit -m "Add hello.rb and personal.rb scripts" # Commits staged changes with a descriptive message


Push to GitHub:
To share your local changes with a remote repository (like on GitHub), you need to push them.
First-time push to a new remote:
git remote add origin <repo-url> # Links your local repository to a remote one (replace <repo-url>)
git push -u origin personal-info # Pushes your branch to the remote and sets it as the upstream branch


Subsequent pushes:
git push


