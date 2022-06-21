module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      // Open google meet in Brave
      match: ["meet.google.com/*", "key.sc/*"],
      browser: "Brave Browser"
    }
  ],
  options: {
    hideIcon: true
  }
};