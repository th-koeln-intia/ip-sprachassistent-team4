---
layout: default
title: Raven
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


# Raven
To wake up the voice assistant a [wake word](/pages/knowledge/wake-word) is necessary. There are several engines to be 
able to react to a wake word. [Raven](https://github.com/rhasspy/rhasspy-wake-raven){:target="_blank"} is the 
[wake word](/pages/knowledge/wake-word) engine we used in our project. 
After the self-selected wake word has been detected, a command can be spoken.

## Advantages
- Easy setup
- Only three [wake word](/pages/knowledge/wake-word) templates need to be set
- Easy to configure
- Good precision with 3-4 syllables long words

## Disadvantages
- Wake word should not be too short
- A wake word should not sound like common words

## Conclusion
If you keep in mind that your [wake word](/pages/knowledge/wake-word) is not too short or similar to common words, 
Raven is a really good [wake word](/pages/knowledge/wake-word) engine.
These rules apply to all systems that use a [wake word](/pages/knowledge/wake-word).