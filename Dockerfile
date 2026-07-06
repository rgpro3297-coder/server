FROM ubuntu:22.04

# প্রয়োজনীয় প্যাকেজ, curl, sudo, java এবং playit ইনস্টল করা
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Playit.gg ইনস্টল করার অফিশিয়াল স্ক্রিপ্ট রান
RUN curl -SsL https://playit-cloud.github.io/playit-arm/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg > /dev/null \
    && echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/playit-arm/apt/ ./" | sudo tee /etc/apt/sources.list.d/playit.list \
    && apt-get update \
    && apt-get install -y playit

# ওয়ার্কিং ডিরেক্টরি সেটআপ
WORKDIR /server

# তোমার সার্ভারের ফাইল ও স্টার্ট স্ক্রিপ্ট কপি করা
COPY . .

# start.sh ফাইলটিকে এক্সিকিউটেবল (Executable) করার পারমিশন দেওয়া
RUN chmod +x start.sh

# Koyeb-এর জন্য পোর্ট এক্সপোজ করা (যদি প্যানেল বা ওয়েব পোর্ট থাকে)
EXPOSE 8080

# স্টার্ট স্ক্রিপ্ট রান করা
CMD ["./start.sh"]
