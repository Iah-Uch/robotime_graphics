# RoboTime Graphics

A simple **Robot Framework** script to add bulk events to the [Time Graphics](https://time.graphics/) timeline tool. 

🚨 **This is a base script!** 🚨  
It provides a foundational structure that you **must adapt** to your specific needs. The **xpaths** and **workflow** may differ depending on changes to the Time Graphics website. Be prepared to update the script if the website structure changes. This repository is ideal as a starting point but assumes that users will customize it as needed.

---

## 🚀 Features

- Automates logging into the Time Graphics website.
- Adds events to a timeline based on a CSV file.
- Customizable event types with associated colors.
- Saves the timeline after adding events.
- Provides a simple, adaptable framework for extending or modifying the automation process.

---

## 🛠️ Requirements

### Software Requirements
- **Python** (Version 3.7 or later recommended)
- **Robot Framework** 
- **SeleniumLibrary** for Robot Framework

```bash
pip install robotframework robotframework-seleniumlibrary
```

### System Requirements
- A stable internet connection.
- Access to a Time Graphics account with valid credentials.
- A browser supported by Selenium (e.g., Chrome, Firefox).

---

## 📂 File Structure

```
.
├── robotime_graphics.robot        # Main script for automation
├── my_data.csv                    # Sample CSV file (replace with your data)
├── README.md                      # Documentation (you're reading it!)
```

---

## 🔧 Setup and Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Iah-Uch/robotime_graphics.git
   cd robotime_graphics
   ```

2. **Install Dependencies**
   Set up a Python environment (using Virtualenv is recommended):
   ```bash
   pip install robotframework robotframework-seleniumlibrary
   ```

3. **Configure Variables**
   Open `robotime_graphics.robot` and edit these variables:
   - **`${URL}`**: Update with the Time Graphics URL.
   - **`${CSV_FILE}`**: Path to your event CSV file.
   - **`${EMAIL}`** and **`${PASSWORD}`**: Your Time Graphics account credentials.
   - **`&{EVENT_COLORS}`**: Map event types to colors.

---

## 📝 Usage

1. **Prepare Your CSV File**
   Make sure your file matches the expected format, or customize the script to match your file's structure.

   Default format:
   ```csv
   title,summary,event_type,Timestamp
   Morning Workout,"Did 30 minutes of cardio.",EXERCISE,2023-11-18 06:30:00
   Breakfast,"Had oatmeal and coffee.",MEAL,2023-11-18 07:30:00
   ```

2. **Run the Script**
   Execute the script with Robot Framework:
   ```bash
   robot robotime_graphics.robot
   ```

3. **Review the Timeline**
   After running the script, your events will appear in the Time Graphics timeline. A `Sleep` command allows time for manual inspection.

---

## 🛠️ Customizations

This repository is intentionally basic to accommodate a wide range of use cases. You'll likely need to adapt it to suit your specific needs.

### **1. XPaths**
The current script relies on specific **xpaths** to interact with the Time Graphics website. These **may change** if the website layout updates. Use your browser's developer tools (e.g., Chrome DevTools) to inspect and update these paths if needed.

### **2. Variables**
- **`${URL}`**: Replace with the correct Time Graphics URL for your region or testing environment.
- **`${CSV_FILE}`**: Update to point to your custom CSV file.
- **`${EMAIL}` and `${PASSWORD}`**: Enter your login credentials.
- **`&{EVENT_COLORS}`**: Add new event types or customize colors.

### **3. Event Fields**
The script assumes events have:
- A **title**
- A **summary**
- An **event_type** (mapped to a color)
- A **timestamp**

If your event data has additional or different fields, you'll need to modify the corresponding keywords in the script.

### **4. Timeout Values**
Adjust `Wait Until Element Is Visible` timeouts to handle slower networks or website responsiveness.

---

## 📊 CSV Format

By default, the script expects a CSV file in this format:
```csv
title,summary,event_type,Timestamp
Morning Walk,"A quick 15-minute walk outside.",EXERCISE,2024-01-01 07:00:00
Lunch,"Had a healthy salad.",MEAL,2024-01-01 12:30:00
```

- **title**: A short title for the event.
- **summary**: Detailed information about the event.
- **event_type**: A category for the event, matched to `&{EVENT_COLORS}`.
- **Timestamp**: Event date and time in `YYYY-MM-DD HH:MM:SS` format.

---

## 🛡️ Important Notes

1. **This is a Base Script**  
   It is not guaranteed to work "out-of-the-box" for all users due to potential changes in the Time Graphics interface. 

2. **XPaths May Differ**  
   Inspect and update the xpaths if elements cannot be located. Use browser developer tools to inspect the site.

3. **Customization Required**  
   Adapt the script to your specific needs, including:
   - Custom event fields
   - Changes in the website's structure
   - Additional features

---

## 💡 Future Enhancements

- Support for dynamic XPath generation.
- Improved error handling for invalid data or website changes.
- Compatibility with multiple event sources or file types.

---

## 🧑‍🤝‍🧑 Contributing

Contributions are welcome! Here's how you can get involved:
1. Fork the repository.
2. Create a branch for your feature or bug fix:
   ```bash
   git checkout -b feature/new-feature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add new feature"
   ```
4. Push your branch:
   ```bash
   git push origin feature/new-feature
   ```
5. Submit a pull request!

---

## 📜 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Feel free to adapt, extend, and enhance this script for your needs. Enjoy automating your timelines! 😊
