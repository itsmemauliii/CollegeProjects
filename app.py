import streamlit as st
import openai
import speech_recognition as sr
from pytube import YouTube
import os
from deep_translator import GoogleTranslator

# Load API Key (Set in Streamlit Secrets or directly here)

openai.api_key = st.secrets["openai"]["api_key"]
openai.api_key = os.getenv("Grow With Me")
# Initialize Translator
translator = GoogleTranslator(source="en", target="hi")

# Function to detect the last letter of a song (Hindi)
def get_last_letter(song_name):
    translation = translator.translate(song_name)
    return translation.strip()[-1]  # Last character in Hindi

# Function to get a song from OpenAI
response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": prompt}],
    max_tokens=50
)

# Function to fetch YouTube link
def get_youtube_link(song_name):
    search_query = f"{song_name} Bollywood song official"
    return f"https://www.youtube.com/results?search_query={search_query.replace(' ', '+')}"

# Function to record and process voice input
def recognize_speech():
    recognizer = sr.Recognizer()
    with sr.Microphone() as source:
        st.info("Listening... Sing or say a Bollywood song!")
        try:
            audio = recognizer.listen(source, timeout=5)
            text = recognizer.recognize_google(audio)
            return text
        except sr.UnknownValueError:
            st.error("Sorry, could not understand. Try again.")
        except sr.RequestError:
            st.error("Speech recognition error. Please check your connection.")

# Streamlit UI Setup
st.title("🎵 Antakshari AI - Bollywood Singing Agent")
st.subheader("Play Antakshari with AI! Enter a song or sing, and let AI respond.")

# User Input Section
input_method = st.radio("Choose input method:", ("🎤 Sing (Voice Input)", "⌨️ Type (Text Input)"))

if input_method == "⌨️ Type (Text Input)":
    user_song = st.text_input("Enter a Bollywood song:")
    submit = st.button("Submit Song")
elif input_method == "🎤 Sing (Voice Input)":
    if st.button("Record 🎤"):
        user_song = recognize_speech()
        if user_song:
            st.success(f"Recognized Song: {user_song}")

# Process and AI Response
if "user_song" in locals() and user_song:
    last_letter = get_last_letter(user_song)
    st.write(f"🎵 **Last Letter:** {last_letter}")

    ai_song = get_ai_song(last_letter)
    st.success(f"🎶 AI Suggests: {ai_song}")

    # YouTube Link
    yt_link = get_youtube_link(ai_song)
    st.markdown(f"[🎥 Watch on YouTube]({yt_link})")

    # AI Fun Comment
    ai_comment = openai.Completion.create(
        model="text-davinci-003",
        prompt="Give a fun response to an Antakshari player",
        max_tokens=30
    ).choices[0].text.strip()

    st.info(f"🤖 AI: {ai_comment}")
