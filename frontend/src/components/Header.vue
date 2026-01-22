<template>
  <header class="bg-white border-b border-gray-200">
    <nav class="container mx-auto px-4 py-4">
      <div class="flex items-center relative">
        <a href="/" class="flex items-center">
          <img src="/images/ccl-logo.png" alt="Cavalry Chapel Lippstadt Logo" class="h-16" />
        </a>
        <ul class="menu-desktop items-center gap-6 flex-1 justify-center">
          <li>
            <a href="/" :class="['nav-link transition-colors', isActive('/') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="updateCurrentPath()">Home</a>
          </li>
          <li>
            <a href="/events" :class="['nav-link transition-colors', isActive('/events') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="updateCurrentPath()">Events</a>
          </li>
          <li>
            <a href="/teachings" :class="['nav-link transition-colors', isActive('/teachings') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="updateCurrentPath()">Teachings</a>
          </li>
          <li>
            <a href="/mission" :class="['nav-link transition-colors', isActive('/mission') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="updateCurrentPath()">Mission</a>
          </li>
          <li>
            <a href="/donation" :class="['nav-link transition-colors', isActive('/donation') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="updateCurrentPath()">Donation</a>
          </li>
          <li>
            <a href="/contact" :class="['nav-link transition-colors', isActive('/contact') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="updateCurrentPath()">Contact</a>
          </li>
        </ul>
        <button 
          @click="menuOpen = !menuOpen" 
          class="hamburger-button p-2 text-brand-steelblue hover:text-brand-peach transition-colors"
          aria-label="Toggle menu"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path v-if="!menuOpen" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
        <div class="flex items-center gap-3 ml-auto flags-desktop">
          <button class="text-2xl hover:opacity-70 transition-opacity cursor-pointer pr-3 border-r border-gray-300" aria-label="Switch to German">
            🇩🇪
          </button>
          <button class="text-2xl hover:opacity-70 transition-opacity cursor-pointer" aria-label="Switch to English">
            🇺🇸
          </button>
        </div>
      </div>
      <transition name="menu">
        <div v-if="menuOpen" class="menu-mobile mt-4 pb-4">
          <ul class="flex flex-col gap-4 items-center">
            <li class="menu-item">
              <a href="/" :class="['nav-link block transition-colors', isActive('/') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="menuOpen = false; updateCurrentPath()">Home</a>
            </li>
            <li class="menu-item">
              <a href="/events" :class="['nav-link block transition-colors', isActive('/events') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="menuOpen = false; updateCurrentPath()">Events</a>
            </li>
            <li class="menu-item">
              <a href="/teachings" :class="['nav-link block transition-colors', isActive('/teachings') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="menuOpen = false; updateCurrentPath()">Teachings</a>
            </li>
            <li class="menu-item">
              <a href="/mission" :class="['nav-link block transition-colors', isActive('/mission') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="menuOpen = false; updateCurrentPath()">Mission</a>
            </li>
            <li class="menu-item">
              <a href="/donation" :class="['nav-link block transition-colors', isActive('/donation') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="menuOpen = false; updateCurrentPath()">Donation</a>
            </li>
            <li class="menu-item">
              <a href="/contact" :class="['nav-link block transition-colors', isActive('/contact') ? 'text-brand-peach font-semibold' : 'text-brand-steelblue hover:text-brand-peach']" @click="menuOpen = false; updateCurrentPath()">Contact</a>
            </li>
          </ul>
          <div class="flex items-center justify-center gap-3 mt-6 flags-mobile">
            <button class="text-2xl hover:opacity-70 transition-opacity cursor-pointer pr-3 border-r border-gray-300" aria-label="Switch to German">
              🇩🇪
            </button>
            <button class="text-2xl hover:opacity-70 transition-opacity cursor-pointer" aria-label="Switch to English">
              🇺🇸
            </button>
          </div>
        </div>
      </transition>
    </nav>
  </header>
</template>

<script>
import { ref, computed, onMounted, onUnmounted } from 'vue'

export default {
  name: 'Header',
  setup() {
    const menuOpen = ref(false)
    const currentPath = ref(window.location.pathname)
    
    const updateCurrentPath = () => {
      currentPath.value = window.location.pathname
    }
    
    const isActive = (path) => {
      if (path === '/') {
        return currentPath.value === '/' || currentPath.value === ''
      }
      return currentPath.value === path || currentPath.value.startsWith(path + '/')
    }
    
    onMounted(() => {
      window.addEventListener('popstate', updateCurrentPath)
    })
    
    onUnmounted(() => {
      window.removeEventListener('popstate', updateCurrentPath)
    })
    
    return { 
      menuOpen,
      isActive,
      currentPath,
      updateCurrentPath
    }
  }
}
</script>

<style scoped>
header {
  background-color: white;
}

@media (max-width: 900px) {
  .menu-desktop {
    display: none;
  }
  
  .menu-mobile {
    display: block;
  }
  
  .hamburger-button {
    display: block;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
  }
}

@media (max-width: 580px) {
  .flags-desktop {
    display: none;
  }
  
  .flags-mobile {
    display: flex;
  }
  
  .hamburger-button {
    position: static;
    transform: none;
    margin-left: auto;
  }
}

@media (min-width: 581px) {
  .flags-mobile {
    display: none;
  }
}

@media (min-width: 901px) {
  .menu-desktop {
    display: flex;
  }
  
  .menu-mobile {
    display: none;
  }
  
  .hamburger-button {
    display: none;
  }
}

/* Menu animation */
.menu-enter-active {
  animation: slideDown 0.3s ease-out;
}

.menu-leave-active {
  animation: slideUp 0.3s ease-in;
}

.menu-enter-from {
  opacity: 0;
  transform: translateY(-20px);
}

.menu-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideUp {
  from {
    opacity: 1;
    transform: translateY(0);
  }
  to {
    opacity: 0;
    transform: translateY(-20px);
  }
}

/* Menu item animation */
.menu-item {
  animation: fadeInUp 0.4s ease-out;
  animation-fill-mode: both;
}

.menu-item:nth-child(1) { animation-delay: 0.05s; }
.menu-item:nth-child(2) { animation-delay: 0.1s; }
.menu-item:nth-child(3) { animation-delay: 0.15s; }
.menu-item:nth-child(4) { animation-delay: 0.2s; }
.menu-item:nth-child(5) { animation-delay: 0.25s; }
.menu-item:nth-child(6) { animation-delay: 0.3s; }

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Underline animation */
.nav-link {
  position: relative;
  display: inline-block;
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: -4px;
  left: 0;
  width: 0;
  height: 2px;
  background-color: var(--brand-peach);
  transition: width 0.3s ease-out;
}

.nav-link:hover::after {
  width: 100%;
}

.nav-link.text-brand-peach::after {
  width: 100%;
  background-color: var(--brand-peach);
}
</style>
