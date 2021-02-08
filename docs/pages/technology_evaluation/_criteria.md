---
layout: default
title: Criteria
parent: Technology Evaluation
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Criteria

Für das Projekt sind ein paar Kriterien für die Bewertung auf der Seite `https://www.archi-lab.io/pages/viewpage.action?pageId=41156613` festgelegt.
In diesem Abschnitt gehen wir auf die einzelnen Kriterien ein.

|criteria|description |
|----------------|-------------------------------------------------------------------------------------|
|Security| any concern about privacy ?|
|Usability | Is the voice assistant easy to use ?|
|Reliability| How reliable is the voice assistant ?|
|Robustness| How robust is the voice assistant ?|
|Suitability for handicapped and educational assistance| How useful is the system for handicapped and educational assistance ?

## Security
By using Rhasspy, you always have the data stored locally with you, so that a distribution on the Internet does not take place. However, it is possible to access the user interface of Rhasspy from the outside and make changes here. The same applies to the Node Red.
Here it would make more sense to protect the access to the user interface with a password.

## Usability
The system is very easy to use. You only need to say the wake work plus the command you want and the system executes the command. The problem is that the spoken sentences do not always work properly due to the Speech-To-Text service.

## Reliability
The services used (Snips and Deepspeech) work reliably. As soon as the spoken command is recognized, the system produces the desired result.

## Robustness
The system is very robust and it rarely comes to the service crashed.
For the different services we have activated the systemctl, so that with every new start from the Raspberry Pi all services are immediately available.

## Suitability for handicapped and educational assistance

In principle, the system can be very suitable for handicapped and educational assistance.The wake work and the commands can be adapted and expanded as required.
As already mentioned, the text-to-speech sounds very artificial and difficult to understand and that can lead to problems.

