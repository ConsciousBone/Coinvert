# Coinvert
**A simple currency converter for iOS devices. Made for Hack Club's Siege week 5.**

![Coinvert conversion page](Image1.png) ![Coinvert rates page](Image2.png)
![Coinvert settings page](Image3.png) ![Coinvert onboarding page](Image4.png)

## Description
Coinvert is an extremely simple currency converter for iPhone and iPad, as well as Mac and Apple Vision Pro using Apple's *Designed for iPad* feature!  
It supports over 200 currencies, including some cryptocurrencies.

## How to get Coinvert
*This looks sick, how do I try this out?* I don't hear you asking, oh well, here's how anyway!  
This guide only covers iPhone, iPad, and Apple Silicon Macs; if you want to use this on an Apple Vision Pro, you're on your own.
1. Download [Sideloadly](https://sideloadly.io/#download) and its requirements (Macs have none, Windows machines need iTunes and iCloud **not from the Microsoft Store**) so you can sideload the IPA file onto your iPhone/iPad.  
(I would've put this on the App Store or on TestFlight, but App Review would not approve it before the end of Week 5, they're kinda slow.)
2. Go to the *Releases* page on GitHub. This is on the right of this README on desktop, and at the bottom of the page on mobile.
3. Find the latest release (should be the first one that shows up) and download the `Coinvert.ipa` file.
4. Open up Sideloadly, click the box with the file icon and `IPA` inside it, then select the `Coinvert.ipa` file you downloaded previously.
5. Select your iPhone or iPad in the *iDevice* dropdown (you may have to 'trust' your computer before it appears), and put your Apple Account/ID email into the *Apple ID* text box.
6. Press *Start*, enter your Apple Account/ID's password and, if prompted, the verification code sent to your devices. **Your password will never be sent to the developers of Sideloadly, it goes straight to Apple and no one else sees it.**
7. Wait for the sideloading process to happen, then once it's finished, **congratulations!** You should now have Coinvert installed on your iPhone/iPad. *If you are prompted to enable *Developer Mode* upon attempting to launch Coinvert, do so.*

## Inspiration
I made this as I found most currency converters available on the App Store to either have a design that does not feel native to iOS, or be littered with ads/in app purchases. Coinvert has neither! It will always be open source, completely free, and have absolutely no advertisements.

## Tech stack
- Swift (including SwiftUI and SwiftData)
- [exchange-api](https://github.com/fawazahmed0/exchange-api) *(the whole thing would not be possible without this, this API is so cool, and completely free with no limits!!)*
