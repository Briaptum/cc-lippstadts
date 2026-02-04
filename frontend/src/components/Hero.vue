<template>
  <section class="hero-section relative overflow-hidden w-full" style="margin: 0; padding: 0; width: 100vw;" @mouseenter="pauseAutoplay" @mouseleave="resumeAutoplay">
    <div class="banner-container relative w-full" :class="{ 'banner-loaded': isLoaded }" style="width: 100vw;">
      <div 
        v-for="(image, index) in banners" 
        :key="index"
        class="banner-slide absolute inset-0 w-full h-full"
        :style="{ 
          opacity: currentIndex === index ? 1 : 0,
          zIndex: currentIndex === index ? 10 : 0,
          pointerEvents: currentIndex === index ? 'auto' : 'none',
          transition: 'opacity 1s ease-in-out'
        }"
      >
        <img 
          :src="`/images/${image}`" 
          :alt="`Banner ${index + 1}`"
          style="width: 100%; height: 100%; object-fit: contain; object-position: center; display: block; position: absolute; top: 0; left: 0; right: 0; bottom: 0;"
          @error="handleImageError"
          @load="handleImageLoad"
        />
      </div>
      
      <!-- Navigation dots -->
      <div class="absolute bottom-6 left-1/2 transform -translate-x-1/2 flex gap-2 z-10" :class="{ 'controls-loaded': isLoaded }">
        <button
          v-for="(image, index) in banners"
          :key="index"
          @click="goToSlide(index)"
          :class="['w-3 h-3 rounded-full transition-all duration-300', currentIndex === index ? 'bg-brand-peach w-8' : 'bg-white bg-opacity-50 hover:bg-opacity-75']"
          :aria-label="`Go to slide ${index + 1}`"
        ></button>
      </div>
      
      <!-- Navigation arrows -->
      <button
        @click="handlePrevClick"
        class="nav-button nav-button-prev absolute top-1/2 z-10 bg-black bg-opacity-50 hover:bg-opacity-70 text-white rounded-full transition-all duration-300 shadow-lg cursor-pointer nav-arrow"
        :class="{ 'arrow-loaded': isLoaded }"
        aria-label="Previous slide"
      >
        <svg class="nav-icon" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
        </svg>
      </button>
      <button
        @click="handleNextClick"
        class="nav-button nav-button-next absolute top-1/2 z-10 bg-black bg-opacity-50 hover:bg-opacity-70 text-white rounded-full transition-all duration-300 shadow-lg cursor-pointer nav-arrow"
        :class="{ 'arrow-loaded': isLoaded }"
        aria-label="Next slide"
      >
        <svg class="nav-icon" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />
        </svg>
      </button>
    </div>
  </section>
</template>

<script>
import { ref, onMounted, onUnmounted } from 'vue'

export default {
  name: 'Hero',
  setup() {
    const banners = ['banner1.jpg', 'banner2.jpg', 'banner3.jpg']
    const currentIndex = ref(0)
    const isLoaded = ref(false)
    let autoplayInterval = null
    
    const nextSlide = () => {
      currentIndex.value = (currentIndex.value + 1) % banners.length
    }
    
    const previousSlide = () => {
      currentIndex.value = (currentIndex.value - 1 + banners.length) % banners.length
      // Restart autoplay after manual navigation
      stopAutoplay()
      startAutoplay()
    }
    
    const handleNextClick = () => {
      nextSlide()
      // Restart autoplay after manual navigation
      stopAutoplay()
      startAutoplay()
    }
    
    const handlePrevClick = () => {
      previousSlide()
    }
    
    const goToSlide = (index) => {
      currentIndex.value = index
      // Restart autoplay after manual navigation
      stopAutoplay()
      startAutoplay()
    }
    
    const handleImageError = (event) => {
      console.error('Image failed to load:', event.target.src)
      console.error('Trying to load from:', `/images/${event.target.src.split('/').pop()}`)
      // Try alternative path
      const img = event.target
      const originalSrc = img.src
      img.src = `/images/${originalSrc.split('/').pop()}`
    }
    
    const handleImageLoad = (event) => {
      console.log('Image loaded successfully:', event.target.src)
    }
    
    const startAutoplay = () => {
      // Clear any existing interval first
      stopAutoplay()
      autoplayInterval = setInterval(() => {
        nextSlide()
      }, 2000) // Change slide every 2 seconds
    }
    
    const stopAutoplay = () => {
      if (autoplayInterval) {
        clearInterval(autoplayInterval)
        autoplayInterval = null
      }
    }
    
    const pauseAutoplay = () => {
      stopAutoplay()
    }
    
    const resumeAutoplay = () => {
      startAutoplay()
    }
    
    onMounted(() => {
      // Ensure first slide is visible
      currentIndex.value = 0
      // Trigger loading animation
      setTimeout(() => {
        isLoaded.value = true
      }, 100)
      // Small delay to ensure DOM is ready
      setTimeout(() => {
        startAutoplay()
      }, 800)
    })
    
    onUnmounted(() => {
      stopAutoplay()
    })
    
    return {
      banners,
      currentIndex,
      isLoaded,
      nextSlide,
      previousSlide,
      goToSlide,
      handleNextClick,
      handlePrevClick,
      handleImageError,
      handleImageLoad,
      startAutoplay,
      stopAutoplay,
      pauseAutoplay,
      resumeAutoplay
    }
  }
}
</script>

<style scoped>
.hero-section {
  width: 100%;
  display: block;
  margin: 0;
  padding: 0;
}

.banner-container {
  position: relative;
  width: 100vw;
  height: 60vh;
  min-height: 400px;
  max-height: 800px;
  background-color: #f0f0f0;
  background-image: linear-gradient(to bottom, #f5f5f5, #e8e8e8);
  margin: 0;
  padding: 0;
  overflow: hidden;
}

@media (max-width: 900px) {
  .banner-container {
    height: 50vh;
    min-height: 350px;
    max-height: 600px;
  }
}

@media (max-width: 580px) {
  .banner-container {
    height: 40vh;
    min-height: 300px;
    max-height: 500px;
  }
}

@media (max-width: 400px) {
  .banner-container {
    height: 35vh;
    min-height: 250px;
    max-height: 400px;
  }
}

/* Responsive navigation buttons */
.nav-button {
  padding: 0;
  width: 3rem;
  height: 3rem;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  aspect-ratio: 1;
  box-sizing: border-box;
  transform: translateY(-50%);
}

.nav-button-prev {
  left: 1rem;
}

.nav-button-next {
  right: 1rem;
}

.nav-icon {
  width: 1.5rem;
  height: 1.5rem;
  flex-shrink: 0;
  display: block;
}

@media (max-width: 900px) {
  .nav-button {
    padding: 0 !important;
    width: 2.5rem !important;
    height: 2.5rem !important;
    aspect-ratio: 1 !important;
  }
  
  .nav-button-prev {
    left: 0.5rem !important;
  }
  
  .nav-button-next {
    right: 0.5rem !important;
  }
  
  .nav-icon {
    width: 1.25rem !important;
    height: 1.25rem !important;
  }
  
  .nav-arrow.arrow-loaded {
    transform: translateY(-50%) scale(1) !important;
  }
}

@media (max-width: 580px) {
  .nav-button {
    padding: 0 !important;
    width: 2rem !important;
    height: 2rem !important;
    aspect-ratio: 1 !important;
  }
  
  .nav-button-prev {
    left: 0.25rem !important;
  }
  
  .nav-button-next {
    right: 0.25rem !important;
  }
  
  .nav-icon {
    width: 1rem !important;
    height: 1rem !important;
  }
  
  .nav-arrow.arrow-loaded {
    transform: translateY(-50%) scale(1) !important;
  }
}

@media (max-width: 400px) {
  .nav-button {
    padding: 0 !important;
    width: 1.75rem !important;
    height: 1.75rem !important;
    aspect-ratio: 1 !important;
  }
  
  .nav-button-prev {
    left: 0.25rem !important;
  }
  
  .nav-button-next {
    right: 0.25rem !important;
  }
  
  .nav-icon {
    width: 0.875rem !important;
    height: 0.875rem !important;
  }
  
  .nav-arrow.arrow-loaded {
    transform: translateY(-50%) scale(1) !important;
  }
}

.banner-slide {
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}

.banner-slide img {
  object-fit: contain;
  object-position: center;
  width: 100%;
  height: 100%;
  display: block;
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}

/* Loading animations */
.banner-container {
  opacity: 0;
  transform: scale(1.05);
  transition: opacity 0.8s ease-out, transform 0.8s ease-out;
}

.banner-container.banner-loaded {
  opacity: 1;
  transform: scale(1);
}

.controls-loaded {
  animation: fadeInUp 0.6s ease-out 0.4s both;
}

.nav-arrow {
  opacity: 0;
  transform: translateY(-50%) scale(0.8);
}

.nav-arrow.arrow-loaded {
  opacity: 1;
  transform: translateY(-50%) scale(1) !important;
  transition: opacity 0.5s ease-out, transform 0.5s ease-out;
}

.nav-arrow:first-of-type.arrow-loaded {
  animation: slideInLeft 0.6s ease-out 0.6s both;
}

.nav-arrow:last-of-type.arrow-loaded {
  animation: slideInRight 0.6s ease-out 0.6s both;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateX(-50%) translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateX(-50%) translateY(0);
  }
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateY(-50%) translateX(-20px) scale(0.8);
  }
  to {
    opacity: 1;
    transform: translateY(-50%) translateX(0) scale(1);
  }
}

@keyframes slideInRight {
  from {
    opacity: 0;
    transform: translateY(-50%) translateX(20px) scale(0.8);
  }
  to {
    opacity: 1;
    transform: translateY(-50%) translateX(0) scale(1);
  }
}

</style>
