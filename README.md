# Movie Recommendation System in Flutter using ONNX Runtime

This Flutter application serves as a proof of concept (PoC) to explore the capabilities and efficiency of using ONNX Runtime for running inference in mobile applications. The primary objective is not to create a complex recommendation system but to demonstrate the feasibility and performance of embedding ONNX models within a Flutter project.

## Features

- **User Preference Input:** A screen that allows users to express their movie preferences in natural language.
- **Movie Listing:** Two horizontally scrollable lists of upcoming movies:
  - **Default List:** Movies displayed as retrieved from the TMDb API.
  - **Sorted List:** Movies sorted based on the calculated similarity between movie descriptions and the user's preferences.

## How It Works

- **Preference Input:** The user inputs their movie preferences in a text field.
- **Fetch Movies:** The app retrieves a list of upcoming movies, including their descriptions, from the TMDb API.
- **Generate Embeddings:** Using the MiniLM-L6-v2 SentenceTransformers model, the app converts both the movies' descriptions and the user's preference text into embeddings.
- **Calculate Similarity:** The app computes cosine similarity between the user's preference embedding and each movie's description embedding.
- **Sort Movies:** Based on the similarity scores, the app sorts the movies to align with the user's preferences.

## Technologies and methods used

The app's core functionality involves parsing user preferences and recommending upcoming movies based on those preferences. Here’s a detailed breakdown of the technologies and methods used:

- **ONNX Runtime:** ONNX Runtime is an open-source performance-focused scoring engine for Open Neural Network Exchange (ONNX) models. ONNX is a standard for representing machine learning models that allows models to be used across different software frameworks, ensuring flexibility and interoperability. In this app, the ONNX Runtime is used to deploy the MiniLM-L6-v2 SentenceTransformers model efficiently on mobile devices, enabling fast, real-time inference directly within the Flutter application.

- **MiniLM-L6-v2 SentenceTransformers:** The MiniLM-L6-v2 is a transformer-based model optimized for creating sentence embeddings. These embeddings are high-dimensional vectors that represent the semantic meanings of sentences. By transforming both the user’s preference text and the movie descriptions into these embeddings, the system can perform semantic comparisons between seemingly unstructured text data.

- **Calculate Cosine Similarity:** Cosine similarity measures the cosine of the angle between two vectors projected in a multi-dimensional space. In the context of this app, it is used to compare the embedding of the user's preference text with the embeddings of each movie description. The result is a similarity score that reflects how closely a movie aligns with the user’s preferences based on the semantic content of their descriptions.

- **Sort Movies Based on Preferences:** Using the cosine similarity scores, the app sorts the movies. Those with the highest scores (i.e., smallest angles between vectors and hence most similar in semantic content to the user's preferences) are presented to the user as the most recommended titles.

To provide a clearer example, imagine a user inputs "I love epic adventures and space battles" as their preference. The app converts this text into an embedding and does the same for each upcoming movie description. It then calculates the cosine similarity between the user’s preference embedding and each movie’s embedding. A movie described as "A grand space opera with stunning visuals of interstellar conflict" would score highly in similarity to the user’s preferences and be recommended.
