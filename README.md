# Roblox UI Script

Delta Header Minimizer is a Roblox script that creates a compact draggable menu with an automatically bottom-positioned header, a minimize control, touch and mouse dragging, and a local sample action status update.

## Install

1. Open Roblox Studio and open the target experience.
2. In Explorer, open `StarterPlayer`.
3. Open `StarterPlayerScripts`.
4. Create a `LocalScript` named `CompactMenu.client.lua`.
5. Copy the contents of `StarterPlayer/StarterPlayerScripts/CompactMenu.client.lua` into the new `LocalScript`.
6. Start Play mode to test the menu.

## Use

1. Run the experience in Play mode.
2. Find the compact menu near the lower-right corner of the screen.
3. Drag the `MENU` header with a mouse or touch input to move the panel.
4. Select the minimize button to hide the menu body.
5. Select the `+` button to restore the menu body.
6. Select `Run Sample Action` to update the local status text.
7. Replace the sample action handler with your own game-specific behavior. Gameplay-changing actions should use validated server-side code and secured `RemoteEvent` communication.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/5d6911b0-da3d-4172-8d83-f9f993e79724?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=5d6911b0-da3d-4172-8d83-f9f993e79724
