const { Client, GatewayIntentBits } = require('discord.js');
const express = require('express');

// ১. এক্সপ্রেস ওয়েব সার্ভার সেটআপ (Render এবং ক্রন-জবের জন্য)
const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Bot is alive and running 24/7!');
});

app.listen(port, () => {
  console.log(`Web server is listening on port ${port}`);
});

// ২. ডিসকর্ড বোট সেটআপ
const client = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
  ],
});

client.once('ready', () => {
  console.log(`Logged in as ${client.user.tag}!`);
});

// একটি সিম্পল টেস্ট কমান্ড (কেউ 'ping' লিখলে বোট 'pong' বলবে)
client.on('messageCreate', (message) => {
  if (message.author.bot) return;

  if (message.content.toLowerCase() === 'ping') {
    message.reply('Pong! 🏓');
  }
});

// ৩. বোট লগইন (টোকেনটি এনভায়রনমেন্ট ভ্যারিয়েবল থেকে আসবে)
client.login(process.env.DISCORD_TOKEN);
