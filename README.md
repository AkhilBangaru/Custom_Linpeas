# 🛡️ CUSTOM LINPEAS

**Custom linPEAS** is an **interactive Linux local enumeration framework** inspired by *linPEAS*, designed with a **clean TUI menu**, **selectable checks**, and **readable output** for learning, labs, and exam environments.

It focuses on **clarity, structure, and usability**, rather than dumping overwhelming output.

> Built for **educational purposes**, **CTF labs**

---

## ✨ Features

* 📋 **Interactive Menu (TUI)**

  * Clean 2-column layout
  * Toggle individual checks (1–24)
  * Select All / Clear All
* 🧠 **Structured Enumeration**

  * Logical categorization of checks
  * Easy to understand output
* 🖥️ **Live Output + File Logging**

  * Output shown on screen
  * Saved automatically to files
* 📁 **Organized Output Files**

  * Predictable, readable filenames
* 🔇 **Noise-Free Execution**

  * Permission errors suppressed
* 🎨 **Custom ASCII Art UI**

  * “CUSTOM LINPEAS” banner
* 🧩 **Easy to Extend**

  * Simple to hook your own checks

---

## 📂 Enumeration Categories

The tool currently includes **24 selectable checks**, grouped logically:

| ID | Category              |
| -- | --------------------- |
| 1  | System Information    |
| 2  | User Information      |
| 3  | Process Information   |
| 4  | Network Information   |
| 5  | Services              |
| 6  | Cron Jobs             |
| 7  | Interesting Files     |
| 8  | Sudo Permissions      |
| 9  | SUID Binaries         |
| 10 | Linux Capabilities    |
| 11 | Password Files        |
| 12 | Login Information     |
| 13 | Available Shells      |
| 14 | Mount Information     |
| 15 | Device Information    |
| 16 | Kernel Information    |
| 17 | Environment Variables |
| 18 | Command History       |
| 19 | Package Information   |
| 20 | Log Files             |
| 21 | Container Info        |
| 22 | Web Server Info       |
| 23 | Backup Files          |
| 24 | Compiler Availability |

---

## 🚀 Installation

No dependencies required beyond standard Linux utilities.

```bash
git clone https://github.com/<your-username>/custom-linpeas.git
cd custom-linpeas
chmod +x custom_lineaps.sh
```

---

## ▶️ Usage

Run the script:

```bash
./custom_lineaps.sh
```

You will see an **interactive menu** where you can:

* Press `1–24` → Toggle individual checks
* Press `A` → Select all checks
* Press `C` → Clear all selections
* Press `S` → Start scan
* Press `Q` → Quit

---

## 📁 Output Structure

All results are saved in a timestamped directory:

```
custom_lineaps_output_YYYYMMDD_HHMMSS/
```

Each command output follows this format:

```
custom_lineaps_<sectionID>_<cmdNumber>_<command>.txt
```

### Example:

```
custom_lineaps_04_01_network_interfaces.txt
custom_lineaps_09_01_suid_binaries.txt
```

This makes it easy to:

* Review findings later
* Attach results to reports
* Navigate during exams or labs

---

## 🧠 Design Philosophy

* **Readable over noisy**
* **Manual thinking over blind automation**
* **Enumeration, not exploitation**
* **Educational and exam-friendly**

This tool is intentionally **non-exploitative** and focuses on helping you **identify attack surfaces**, not abuse them automatically.

---

## 🛠️ Extending the Tool

Adding new checks is straightforward:

1. Create a new function for the check
2. Add it to the menu list
3. Hook it into the scan execution block

The menu system is **row-based and fixed-width**, so UI stays clean.

---

## ⚠️ Disclaimer

This tool is intended **only for authorized environments**, such as:

* Your own systems
* Labs
* CTFs
* Educational practice

Do **not** use this tool on systems you do not own or have explicit permission to test.

---

## 👤 Author

**Akhil Bangaru**
Custom linPEAS — Built with clarity and control in mind.

---

## ⭐ Acknowledgements

* Inspired by **linPEAS**
* Thanks to the offensive security community for continuous learning resources

---
