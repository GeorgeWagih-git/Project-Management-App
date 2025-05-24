# 📁 Project Management App

🎓 **Graduation Project — Task & Project Management System**  
A Flutter-based mobile application that enables managers and employees to efficiently manage projects, assign tasks, track progress, and collaborate in real time.

---

## 🚀 Idea: Problem and Solution

### Problem:
Small teams and businesses often struggle to organize tasks, delegate work, and track deadlines. Most existing tools are too complex, lack local control, or are expensive.

### Solution:
We developed a **simple, user-friendly mobile application** that allows:
- Managers to create and manage projects.
- Team members to view and update their assigned tasks.
- Progress tracking through visual indicators.
- File uploads and secure access.
- Multilingual support and responsive UI.

---

## 🔑 Key Features

- ✅ User Authentication (Login / Signup)
- 🔐 Forgot Password & Reset via Email OTP
- 📝 Add / Edit / Delete Projects (Manager only)
- 📋 Add / Edit / Delete Tasks (Manager only)
- 📈 Project progress calculation based on task status
- 📂 Upload / Open / Delete one file per project (PDF, Word, Excel)
- 🔔 Notifications for deadlines and updates
- 📅 Calendar integration for task deadlines
- 📊 Dashboard with Ongoing & Completed Projects
- 📱 Responsive design and dark mode support

---

## 📱 App Screens Overview

| Screen                 | Description                                               |
|------------------------|-----------------------------------------------------------|
| `Sign Up`              | Register new user (Manager or Employee)                   |
| `Login`                | Authenticate user and navigate to Home                    |
| `Forgot Password`      | Request OTP by email for password reset                   |
| `Reset Password`       | Reset password with OTP                                   |
| `Home`                 | List of Ongoing & Completed Projects                      |
| `Project Details`      | View/edit project info, progress, and tasks               |
| `Task Details`         | View/edit task data, only editable by the manager         |
| `Add/Edit Project`     | Bottom sheet to add or edit project (Manager only)        |
| `Add/Edit Task`        | Bottom sheet to add or edit task (Manager only)           |
| `Upload/Open File`     | Upload or view file attached to a project                 |
| `Calendar`             | View all deadlines in a calendar view                     |
| `Chat (Optional)`      | (If implemented) team discussion module                   |

---

## 💻 Technologies Used

- **Flutter** & Dart 🐦
- **Bloc** Pattern for State Management
- **RESTful API Integration**
- **Dio** for HTTP Requests
- **SharedPreferences** for local storage
- **File Picker & URL Launcher**
- **Responsive UI for Mobile Devices**

---

## 📦 Setup Instructions

1. Clone this repo:
```bash
git clone https://github.com/GeorgeWagih-git/Project-Management-App
