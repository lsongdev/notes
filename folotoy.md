---
layout: default
title: FoloToy
---

# FoloToy

FoloToy a collection of AI Conversation toys that harnesses the latest AI technology and the power of love ♥️. you can personally create a one-of-a-kind toy character, bringing limitless joy to your loved ones.

![Alilo G6](https://folotoy.com/_astro/g6.6c7655a3_Z1yFlhS.avif)

<https://folotoy.com>


## Step 0: Firmware upgrade

Download Firmware: Visit the [firmware download page](https://github.com/FoloToy/folotoy-tool/releases) and select the firmware that corresponds to your device.

+ https://tool.folotoy.com/program
+ https://lsong.org/webesp

Click the 'Connect' button to establish a connection with your device.

Choose the downloaded firmware file, set Address at `0x0` and click the 'Write' button. Wait for a few minutes for the firmware to be written to you device.

***For windows users, you may need to install a driver so that your device can connect to your PC.***

## Step 1: Power On

Rotate the knob on the back of Fofo to turn on the toy and wait for the ear light to flash blue.

To re-enter network configuration mode, long press the character buttons 2 and 7 until Fofo makes a sound.

## Step 2: Connect to Network

Open your phone/tablet/computer and connect to the hotspot named “FoloToy-xxxx”.

Open your browser and enter: 192.168.4.1.

Click the “Configure” button to enter the configuration page.

SSID: Your home/company Wi-Fi name.
Password: The password for the connected Wi-Fi (cannot be empty).

***Only supports 2.4G Wi-Fi, does not support 5G frequency/mixed frequency/Wi-Fi networks requiring web-based login.***

![](https://r2-uploader.lewang.workers.dev/wifiConfigurationPageEn.png)
![](https://r2-uploader.lewang.workers.dev/wifiInputPageEn.png)

After entering the Wi-Fi name and password, click save and wait for the page to load. Do not exit the page or close the browser during this time.

Once loading is complete, click the button to jump to FoloToy.

![](https://r2-uploader.lewang.workers.dev/clickToJumpToFoloToyEn.png)

On the redirected page, log in to your account, and the toy will automatically bind to the account.

## How to Talk

Press and hold the large round button in the middle to talk. Release it when you finish speaking.

## How to Switch Characters

The 7 small round buttons around the toy are used to switch characters. Press one to switch the character.

## [folotoy-server-self-hosting](https://github.com/FoloToy/folotoy-server-self-hosting)

docker-compose.yml

```yaml
version: '3'
volumes:
  emqx-etc:
  emqx-data:
  emqx-log:
services:
  emqx:
    image: emqx/emqx:latest
    restart: always
    ports:
      - "1883:1883/tcp"
      - "18083:18083/tcp"
      - "8083:8083/tcp"
    volumes:
      - emqx-etc:/opt/emqx/etc    
      - emqx-data:/opt/emqx/data
      - emqx-log:/opt/emqx/log
    environment:
      EMQX_NODE_NAME: emqx@node1.emqx.io
  nginx:
    image: nginx:latest
    restart: always
    ports:
      - "8082:80/tcp"
    volumes:
      - ./audio:/usr/share/nginx/html
  folotoy:
    image: lewangdev/folotoy-server:latest
    restart: always
    ports:
      - "8085:8085/udp"
    volumes:
      - ./audio:/audio
      - ./config:/config
    environment:
      TZ: Asia/Shanghai

      LOG_LEVEL: DEBUG

      ROLES_FILE_PATH: /config/roles.json

      # Default STT(Sound To Text) type
      # Options: [openai-whisper, azure-whisper, azure-stt, dify-stt, aliyun-asr, volcengine-asr]
      STT_TYPE: openai-whisper

      # OpenAI Whisper
      #OPENAI_WHISPER_API_BASE: https://one-api.xxxx.com/v1
      OPENAI_WHISPER_KEY: sk-Gnkw1ZnG5rUWbzVl316dddddddddddddddddd
      OPENAI_WHISPER_MODEL: whisper-1
      
      # Azure Whisper
      AZURE_WHISPER_API_BASE: https://xxxxx.openai.azure.com
      AZURE_WHISPER_KEY: 9afbef65bcf6487eeeeeeeeeeeeeeeeeee
      AZURE_WHISPER_DEPLOYMENT_NAME: whisper
      AZURE_WHISPER_API_VERSION: 2023-09-01-preview

      # Azure STT
      AZURE_STT_KEY: 3eba91b6143f4d3eeeeeeeeeeeeeeeeeeeeeeeee
      AZURE_STT_SERVICE_REGION: eastasia

      # Dify STT
      DIFY_STT_API_BASE: https://api.dify.ai/v1
      DIFY_STT_KEY: app-xxxxxxxxxxxxxxxxxxxxx
      
      # Aliyun ASR
      ALIYUN_ASR_ACCESS_KEY_ID: LTxxxxxxxxxxxxxxxxxxxxx
      ALIYUN_ASR_ACCESS_KEY_SECRET: 3zWkHVxxxxxxxxxxxxxxxxxxxxx
      ALIYUN_ASR_APP_KEY: Ltamxxxxxxxxxxxxxxxxxxxxx

      #Volcengine ASR
      VOLCENGINE_ASR_ACCESS_TOKEN: U5joq1ow-Goyxxxxxxxxxxxxxx
      VOLCENGINE_ASR_APP_ID: 4556821315
      VOLCENGINE_ASR_CLUSTER_ID: volcengine_input_common


      # Default LLM(Large Language Model) type
      # Options: ['openai', 'azure-openai', 'gemini', 'dify', 'qianfan', 'xiaodu',
      #           'ollama', 'groq', 'moonshot', 'anthropic', 'zhipu', 'lingyiwanwu', 
      #           'dashscope', 'spark-desk', 'minimax', 'aws-bedrock'， 'coze']
      LLM_TYPE: openai

      # OpenAI
      #OPENAI_OPENAI_API_BASE: https://one-api.xxx.com/v1
      #OPENAI_OPENAI_MODEL: gpt-3.5-turbo
      OPENAI_OPENAI_KEY: sk-5N8F5VXsa7oOZI8Q874601110AAAAAAAAAAAAAAAAAAAAAA

      #Azure OpenAI
      AZURE_OPENAI_KEY: ef0f2781b5a24b15baaaaaaaaaaaaaaaaaaaaaaa
      AZURE_OPENAI_ENDPOINT: https://xxxxx.openai.azure.com/
      AZURE_OPENAI_API_VERSION: "2023-05-15"
      #AZURE_OPENAI_MODEL: gpt-35-turbo

      #DIFY
      DIFY_API_BASE: https://api.dify.ai/v1
      DIFY_KEY: app-5YGbxxxxxxxxxxxxxxxxxxxxx
      
      #Xiaodu API
      XIAODU_CLIENT_ID: xxxxxxxxxxxxxxxxxx
      XIAODU_SECRET: xxxxxxxxxxxxxxxxxxxxx

      # GEMINI
      GEMINI_KEY: AIzaSyxxxxxxxxxxxxxxxxxxk
      
      # Qianfan
      QIANFAN_CLIENT_ID: 13rBTgxxxxxxxxxxxxxxxxxx
      QIANFAN_SECRET: zYxtMIQLexxxxxxxxxxxxxxxxxx

      # Moonshot
      MOONSHOT_API_BASE: https://api.moonshot.cn/v1
      MOONSHOT_KEY: sk-XCLMlj54GDTxxxx
      MOONSHOT_MODEL: moonshot-v1-8k

      # Aliyun Dashscope
      DASHSCOPE_KEY: sk-f4x
      DASHSCOPE_MODEL: qwen-turbo
      DASHSCOPE_ENABLE_SEARCH: "true"
      
      # Lingyiwanwu
      LINGYIWANWU_KEY: 4b2f584b4x
      LINGYIWANWU_MODEL: yi-34b-chat-200k
      
      # Zhipu
      ZHIPU_KEY: 4544625bb0d0ax
      #ZHIPU_MODEL=glm-3-turbo
      
      # Spark Desk
      SPARK_DESK_API_VERSION: v2.0
      SPARK_DESK_APP_ID: d2c1xxxxxxxxxxx
      SPARK_DESK_API_KEY: 10610b3xxxxxxx
      SPARK_DESK_API_SECRET: N2I5xxxxxxxxx
      SPARK_DESK_TEMPERATURE: 0.7
      SPARK_DESK_MAX_TOKENS: 4096
      
      # MINIMAX
      MINIMAX_KEY: eyJhbGciOiJSUzI1NiIsInRxxxxxxxxxxxxxxx

      # AWS Bedrock
      AWS_BEDROCK_ACCESS_KEY_ID: AKIAQLJIxxxxxxxxxxxxxxxxxxx
      AWS_BEDROCK_ACCESS_KEY_SECRET: ss07ojxxW/X7YHZkxxxxxxxxxx
      AWS_BEDROCK_MODEL: anthropic.claude-v2:1
      
      # FastGPT
      FASTGPT_KEY: here-is-app-key-not-account-key
      #FASTGPT_API_BASE: https://api.fastgpt.in/api
      #FASTGPT_CHAT_ID: xxx

      #Coze
      COZE_API_BASE: https://api.coze.cn/open_api/v2
      COZE_PERSONAL_ACCESS_TOKEN: pat_Vl3CaNcFgf67wx
      COZE_BOT_ID: 73568618000000060037

      # If your elevenlabs is a free account, keep 2 here
      VOICE_EXECUTOR_MAX_WORKERS: 2

      # Default TTS(Text to Sound) type
      # Options: [openai-tts, azure-openai-tts, azure-tts, dify-tts, elevenlabs, edge-tts, aliyun-tts, volcengine-tts]
      # edge-tts is Free but slow
      TTS_TYPE: edge-tts

      # Azure TTS
      AZURE_TTS_KEY: 3eba91b6143f4d399edeeeeeeeeeeeeeeeeeeeee
      AZURE_TTS_SERVICE_REGION: eastasia

      # elevenlabs
      ELEVENLABS_TTS_KEY: a920b73991e68d5c9c9aaaaaaaaaaaaaaaa
      ELEVENLABS_TTS_MODEL: eleven_multilingual_v2

      # OpenAI TTS
      OPENAI_TTS_KEY: sk-16XnP3HLHWho21oO2m0AAAAAAAAAAAAAAAAAAAAAA
      OPENAI_TTS_MODEL: tts-1  

      # Aliyun TTS
      ALIYUN_TTS_ACCESS_KEY_ID: LTAI5t91NSxxxxxxxxxxxxxxxxxxxxx
      ALIYUN_TTS_ACCESS_KEY_SECRET: 3zWkHVxxxxxxxxxxxxxxxxxxxxx
      ALIYUN_TTS_APP_KEY: Ltamxxxxxxxxxxxxx

      # Azure Openai TTS
      AZURE_OPENAI_TTS_API_BASE: https://xxx-whisper.openai.azure.com/
      AZURE_OPENAI_TTS_API_VERSION: 2024-02-15-preview
      AZURE_OPENAI_TTS_DEPLOYMENT_NAME: tts
      AZURE_OPENAI_TTS_KEY: 01fdbc75bdxxxxxx
      AZURE_OPENAI_TTS_MODEL: tts-1

      # Dify TTS
      DIFY_TTS_API_BASE: https://api.dify.ai/v1
      DIFY_TTS_KEY: app-5YGbAx

      #Volcengine TTS
      VOLCENGINE_TTS_ACCESS_TOKEN: U5joq1ow-xxxxxxxxxxxx
      VOLCENGINE_TTS_APP_ID: 45568210000
      VOLCENGINE_TTS_CLUSTER_ID: volcano_tts
      VOLCENGINE_TTS_VOICE_TYPE: BV700_V2_streaming
      VOLCENGINE_TTS_EMOTION: conniving
      VOLCENGINE_TTS_LANGUAGE: zh_guangxi

      
      AUDIO_DOWNLOAD_URL: http://your_vps_ip:8082
      AUDIO_SAVE_PATH: /audio

      # MQTT Broker
      MQTT_BROKER_HOST: emqx
      MQTT_BROKER_PORT: 1883
      MQTT_CLIENT_ID: folotoy
      MQTT_USERNAME: folotoy
      MQTT_PASSWORD: folotoy

      SPEECH_UDP_SERVER_HOST: your_vps_ip
      SPEECH_UDP_SERVER_PORT: 8085
```

role.json

```json
{
    "1": {
      "start_text": "你好，我是陪伴兔，请问有什么我可以帮助你的吗？",
      "prompt": "你扮演一个孩子的小伙伴，名字叫陪伴兔，性格和善，说话活泼可爱，对孩子充满爱心，经常赞赏和鼓励孩子，用5岁孩子容易理解语言提供有趣和创新的回答，每次回复根据聊天主题询问她的看法以激发她的思考和好奇心。"
    },
    "2": {
      "start_text": "你好，俺是东北兔，请问有什么俺可以帮助你的吗？",
      "prompt": "你是一个知识渊博，乐于助人的智能机器人,你的名字叫“东北兔”，你的任务是陪我聊天，请用简短的对话方式，用中文讲一段话，每次回答不超过50个字！"
    },
    "3": {
      "start_text": "Hi, I'm Fofo. Nice to meet you.",
      "prompt": "You're a knowledgeable and helpful AI named \"Fofo\". Your task is to chat with me. Please respond in English, keeping your answers brief – no more than 50 words each time!"
    },
    "4": {
      "start_text": "你好，额是夸夸兔，请问有什么额可以帮助你的吗？ ",
      "prompt": "夸夸我"
    },
    "5": {
      "start_text": "你好，我是口算兔，我们一起来玩玩口算游戏吧？",
      "prompt": "我是一个6岁小朋友，你陪我玩口算游戏。你出题，我回答结果。如果答对了你就说好棒，答错了你就告诉我正确答案，并且鼓励我。你一题一题的出，我一个个回答。不要有太多的解释说明。明白了吗？"
    },
    "6": {
      "start_text": "你好，我是台湾兔，请问有什么我可以帮助你的吗？",
      "prompt": "你是一个知识渊博，乐于助人的智能机器人,你的名字叫“台湾兔”，你的任务是陪我聊天，请用简短的对话方式，用中文讲一段话，每次回答不超过50个字！"
    },
    "7": {
      "start_text": "你好，我是小兔，请问有什么我可以帮助你的吗？",
      "prompt": "你是一个知识渊博，乐于助人的智能机器人,你的名字叫“小兔”，你的任务是陪我聊天，请用简短的对话方式，用中文讲一段话，每次回答不超过50个字！"
    }
}
```