import os
import time
import pyautogui

# Replace with the path to the folder where your files are located
folder_path = r"C:\Users\vinay\Desktop\New folder"
os.startfile(folder_path)

# Get a list of files in the folder
file_list = os.listdir(folder_path)

# Select the first file from the folder
if file_list:
    # file_to_print = os.path.join(folder_path, file_list[0])

    # Simulate pressing the Windows key to open the Start menu
    # pyautogui.press('win')
    time.sleep(2)
    pyautogui.press('down')

    # Type "notepad" and press Enter to open Notepad
    # pyautogui.write('notepad')
    # pyautogui.press('enter')

    # time.sleep(2)  # Wait for Notepad to open

    # Type the file path into the Notepad window
    # pyautogui.write(file_to_print)

    # Press Enter to open the file
    pyautogui.press('enter')

    time.sleep(30)  # Wait for the file to open, set this time after testing how long it takes - on average, for a PDF file to open on the system being run

    # Print the file
    pyautogui.hotkey('ctrl', 'p')

    # Wait for the print dialog to appear (adjust the delay if needed)
    time.sleep(2)

    # Simulate filling in the print dialog options and clicking "Print"
    # Modify this section based on your specific print dialog
    # This example simulates pressing Enter to confirm the print
    pyautogui.press('enter')

    # Wait for the print job to complete (adjust the delay if needed)
    time.sleep(5)

    # Close Notepad
    # pyautogui.hotkey('alt', 'f4')


    # Delete the printed file
    file_to_print = os.path.join(folder_path, file_list[0])
    os.remove(file_to_print)

else:
    print("No files found in the folder.")
