

Just a short bash script to live stream to Youtube using a standard \
Raspberry Pi camera module and (in my case) a 4 channel microphone array \
from SEEED (https://wiki.seeedstudio.com/ReSpeaker_4_Mic_Array_for_Raspberry_Pi/). \
Because I had troubles using the ffmpeg tool in a one-liner (it seems \
4 channels aren't yet supported there), I took the detour of using two pipes. \
Audio and video seems synchronous without any changes to the framerates \
of the video and audio data. That used to be quite a problem with the \
Raspberry Pi camera modules.

If you are using the same microphone and follow the setup instructions \
on the above page, this script should work for you too.

