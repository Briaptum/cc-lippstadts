<template>
  <section class="bible-verse-section">
    <div class="container mx-auto px-4 py-8 md:py-12">
      <div class="verse-content max-w-3xl mx-auto">
        <div class="quote-mark quote-mark-left" :class="{ 'quote-visible': isVisible }">"</div>
        <p :class="['verse-text text-xl md:text-2xl lg:text-3xl font-light leading-relaxed', { 'verse-visible': isVisible }]">
          Fixing our eyes on Jesus, the pioneer and perfecter of faith. For the joy set before him he endured the cross, scorning its shame, and sat down at the right hand of the throne of God.
        </p>
        <div class="quote-mark quote-mark-right" :class="{ 'quote-visible': isVisible }">"</div>
        <div class="verse-footer" :class="{ 'reference-visible': isVisible }">
          <div class="verse-line"></div>
          <p class="verse-reference text-sm md:text-base font-medium tracking-widest uppercase">
            Hebrews 12:2
          </p>
          <div class="verse-line"></div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { ref, onMounted } from 'vue'

export default {
  name: 'BibleVerse',
  setup() {
    const isVisible = ref(false)
    
    onMounted(() => {
      setTimeout(() => {
        isVisible.value = true
      }, 300)
    })
    
    return {
      isVisible
    }
  }
}
</script>

<style scoped>
.bible-verse-section {
  background-color: black;
  position: relative;
  overflow: hidden;
}

.verse-content {
  position: relative;
  z-index: 1;
  text-align: center;
  padding: 0 1rem;
}

.quote-mark {
  font-size: 4rem;
  line-height: 1;
  color: rgba(255, 255, 255, 0.3);
  font-family: Georgia, serif;
  font-weight: bold;
  opacity: 0;
  transform: scale(0.5);
  transition: opacity 0.8s ease-out, transform 0.8s ease-out;
}

.quote-mark-left {
  float: left;
  margin-left: -0.5rem;
  margin-top: -0.5rem;
}

.quote-mark-right {
  float: right;
  margin-right: -0.5rem;
  margin-top: -1rem;
}

.quote-mark.quote-visible {
  opacity: 1;
  transform: scale(1);
}

.quote-mark-left.quote-visible {
  transition-delay: 0.2s;
}

.quote-mark-right.quote-visible {
  transition-delay: 0.6s;
}

.verse-text {
  color: white;
  font-style: italic;
  letter-spacing: 0.03em;
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 1s ease-out 0.3s, transform 1s ease-out 0.3s;
  clear: both;
  margin: 1.5rem 0;
  position: relative;
  z-index: 2;
}

.verse-text.verse-visible {
  opacity: 1;
  transform: translateY(0);
}

.verse-footer {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  margin-top: 2rem;
  opacity: 0;
  transform: translateY(15px);
  transition: opacity 0.8s ease-out 0.8s, transform 0.8s ease-out 0.8s;
}

.verse-footer.reference-visible {
  opacity: 1;
  transform: translateY(0);
}

.verse-line {
  width: 2rem;
  height: 1px;
  background-color: rgba(255, 255, 255, 0.4);
  flex-shrink: 0;
}

.verse-reference {
  color: rgba(255, 255, 255, 0.9);
  letter-spacing: 0.15em;
  font-weight: 400;
  white-space: nowrap;
}

@media (min-width: 768px) {
  .quote-mark {
    font-size: 5rem;
  }
  
  .quote-mark-left {
    margin-left: -1rem;
  }
  
  .quote-mark-right {
    margin-right: -1rem;
  }
  
  .verse-text {
    line-height: 1.7;
    margin: 2rem 0;
  }
  
  .verse-line {
    width: 3rem;
  }
}

@media (min-width: 1024px) {
  .quote-mark {
    font-size: 6rem;
  }
  
  .verse-text {
    line-height: 1.8;
  }
}
</style>
