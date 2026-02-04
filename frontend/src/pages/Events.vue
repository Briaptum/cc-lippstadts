<template>
  <div class="events-page min-h-screen bg-gray-50">
    <section class="events-hero relative text-white py-16 md:py-20">
      <div class="events-hero-background absolute inset-0 bg-brand-steelblue"></div>
      <div class="events-hero-overlay absolute inset-0 bg-black bg-opacity-40"></div>
      <div class="container mx-auto px-4 relative z-10">
        <div class="max-w-4xl mx-auto text-center">
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold mb-4">Events</h1>
          <p class="text-xl md:text-2xl text-white text-opacity-90">Join us for worship, fellowship, and community</p>
        </div>
      </div>
    </section>

    <section class="events-content py-12 md:py-16">
      <div class="container mx-auto px-4">
        <div class="max-w-6xl mx-auto">
          <!-- Search Section -->
          <div class="mb-8 bg-white rounded-xl shadow-md p-6">
            <div class="grid md:grid-cols-2 gap-4">
              <!-- Location Search -->
              <div>
                <label for="location-search" class="block text-sm font-semibold text-gray-700 mb-2">
                  Search by Location
                </label>
                <input
                  id="location-search"
                  v-model="locationSearch"
                  type="text"
                  placeholder="Enter location..."
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-brand-steelblue focus:border-transparent transition-all"
                />
              </div>
              
              <!-- Keywords Search -->
              <div>
                <label for="keyword-search" class="block text-sm font-semibold text-gray-700 mb-2">
                  Search by Keywords
                </label>
                <input
                  id="keyword-search"
                  v-model="keywordSearch"
                  type="text"
                  placeholder="Enter keywords..."
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-brand-steelblue focus:border-transparent transition-all"
                />
              </div>
            </div>
            
            <!-- Clear Filters Button -->
            <div v-if="locationSearch || keywordSearch" class="mt-4">
              <button
                @click="clearFilters"
                class="text-sm text-brand-steelblue hover:text-brand-red transition-colors"
              >
                Clear filters
              </button>
            </div>
          </div>

          <!-- Results Count -->
          <div v-if="locationSearch || keywordSearch" class="mb-4 text-gray-600">
            Showing {{ filteredEvents.length }} of {{ events.length }} events
          </div>

          <!-- Events Grid -->
          <div v-if="filteredEvents.length > 0" class="grid md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8">
            <div
              v-for="event in filteredEvents"
              :key="event.id"
              @click="openModal(event)"
              class="event-card bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-all duration-300 cursor-pointer"
            >
              <div class="event-image w-full h-48 overflow-hidden bg-gray-200 relative">
                <!-- Date Badge Overlay -->
                <div v-if="event.date" class="absolute top-4 left-4 bg-white rounded-lg shadow-lg px-4 py-2 z-10">
                  <div class="text-center">
                    <div class="text-3xl font-bold text-brand-steelblue leading-none">{{ formatDay(event.date) }}</div>
                    <div class="text-sm font-semibold text-gray-700 uppercase tracking-wide mt-1">{{ formatMonth(event.date) }}</div>
                  </div>
                </div>
                <img 
                  :src="event.image" 
                  :alt="event.title" 
                  class="block w-full h-full object-cover"
                  style="min-height: 192px;"
                  @error="handleImageError"
                  @load="handleImageLoad"
                />
              </div>
              <div class="p-6">
                <div class="mb-3">
                  <span class="text-sm font-semibold text-brand-steelblue">{{ event.frequency }}</span>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-2">{{ event.title }}</h3>
                <p class="text-gray-600 mb-4">{{ event.description }}</p>
                <div class="space-y-2">
                  <div class="text-sm text-gray-500">
                    <span>{{ event.time }}</span>
                  </div>
                  <div class="text-sm text-gray-500">
                    <span>{{ event.location }}</span>
                  </div>
                </div>
                <div class="mt-4 pt-4 border-t border-gray-200">
                  <span class="text-sm text-brand-red font-medium">
                    View Details
                  </span>
                </div>
              </div>
            </div>
          </div>

          <!-- No Results Message -->
          <div v-else class="text-center py-12">
            <p class="text-xl text-gray-600 mb-2">No events found</p>
            <p class="text-gray-500">Try adjusting your search criteria</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Event Details Modal -->
    <transition name="modal">
      <div
        v-if="showModal && selectedEvent"
        class="modal-overlay fixed inset-0 z-50 flex items-center justify-center p-4 bg-black bg-opacity-60"
        @click.self="closeModal"
      >
        <div class="modal-content relative bg-white rounded-2xl shadow-2xl max-w-4xl w-full max-h-[90vh] overflow-hidden flex flex-col">
          <!-- Close Button -->
          <button
            @click="closeModal"
            class="absolute top-4 right-4 z-10 px-4 py-2 bg-white rounded-lg shadow-lg hover:bg-gray-100 transition-colors text-gray-700 font-medium"
            aria-label="Close modal"
          >
            Close
          </button>

          <!-- Modal Header with Image -->
          <div class="modal-header relative h-64 overflow-hidden">
            <img :src="selectedEvent.image" :alt="selectedEvent.title" class="w-full h-full object-cover" />
            <div class="absolute inset-0 bg-gradient-to-t from-black via-black/50 to-transparent"></div>
            <div class="absolute bottom-0 left-0 right-0 p-6 text-white">
              <div class="mb-2">
                <span class="text-sm font-semibold text-brand-peach">{{ selectedEvent.frequency }}</span>
              </div>
              <h2 class="text-3xl md:text-4xl font-bold mb-2">{{ selectedEvent.title }}</h2>
            </div>
          </div>

          <!-- Modal Body -->
          <div class="modal-body p-6 md:p-8 overflow-y-auto flex-1">
            <!-- Description -->
            <div class="mb-6">
              <h3 class="text-lg font-semibold text-gray-900 mb-3">About This Event</h3>
              <p class="text-gray-700 leading-relaxed">{{ selectedEvent.fullDescription || selectedEvent.description }}</p>
            </div>

            <!-- Event Details Grid -->
            <div class="grid md:grid-cols-2 gap-6 mb-6">
              <!-- Time -->
              <div>
                <h4 class="font-semibold text-gray-900 mb-1">Time</h4>
                <p class="text-gray-600">{{ selectedEvent.time }}</p>
                <p v-if="selectedEvent.duration" class="text-sm text-gray-500 mt-1">Duration: {{ selectedEvent.duration }}</p>
              </div>

              <!-- Location -->
              <div>
                <h4 class="font-semibold text-gray-900 mb-1">Location</h4>
                <p class="text-gray-600">{{ selectedEvent.location }}</p>
                <p v-if="selectedEvent.address" class="text-sm text-gray-500 mt-1">{{ selectedEvent.address }}</p>
              </div>

              <!-- Contact -->
              <div v-if="selectedEvent.contact">
                <h4 class="font-semibold text-gray-900 mb-1">Contact</h4>
                <p class="text-gray-600">{{ selectedEvent.contact }}</p>
                <p v-if="selectedEvent.contactEmail" class="text-sm text-brand-steelblue mt-1">
                  <a :href="`mailto:${selectedEvent.contactEmail}`" class="hover:underline">{{ selectedEvent.contactEmail }}</a>
                </p>
              </div>

              <!-- Additional Info -->
              <div v-if="selectedEvent.additionalInfo">
                <h4 class="font-semibold text-gray-900 mb-1">Additional Information</h4>
                <p class="text-gray-600">{{ selectedEvent.additionalInfo }}</p>
              </div>
            </div>

            <!-- What to Expect -->
            <div v-if="selectedEvent.whatToExpect && selectedEvent.whatToExpect.length > 0" class="mb-6">
              <h3 class="text-lg font-semibold text-gray-900 mb-3">What to Expect</h3>
              <ul class="space-y-2 list-disc list-inside">
                <li v-for="(item, index) in selectedEvent.whatToExpect" :key="index" class="text-gray-700">
                  {{ item }}
                </li>
              </ul>
            </div>
          </div>

          <!-- Modal Footer -->
          <div class="modal-footer border-t border-gray-200 p-6 bg-gray-50">
            <div class="flex flex-col sm:flex-row gap-3 justify-end">
              <button
                @click="closeModal"
                class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors"
              >
                Close
              </button>
              <button
                v-if="selectedEvent.rsvpLink"
                @click="window.open(selectedEvent.rsvpLink, '_blank')"
                class="px-6 py-2 bg-brand-steelblue text-white rounded-lg hover:bg-opacity-90 transition-colors"
              >
                RSVP Now
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
import { ref, computed, onMounted, onUnmounted } from 'vue'

export default {
  name: 'Events',
  setup() {
    const locationSearch = ref('')
    const keywordSearch = ref('')
    const showModal = ref(false)
    const selectedEvent = ref(null)

    const events = ref([
      {
        id: 1,
        title: 'Weekly Worship',
        description: 'Join us every Sunday for worship, teaching, and fellowship.',
        fullDescription: 'Join us every Sunday for an inspiring time of worship, biblical teaching, and warm fellowship. Our weekly worship service is designed to help you connect with God and our community. Whether you\'re new to faith or have been walking with Christ for years, you\'ll find a welcoming atmosphere where you can grow spiritually and build meaningful relationships.',
        frequency: 'Sunday Service',
        date: '2024-12-15',
        time: '10:00 AM',
        duration: '90 minutes',
        location: 'Main Sanctuary, Lippstadt',
        address: '123 Main Street, Lippstadt, Germany',
        contact: 'Pastor John Smith',
        contactEmail: 'pastor@cclippstadt.org',
        additionalInfo: 'Childcare available for children ages 0-5. Coffee and refreshments served after service.',
        whatToExpect: [
          'Contemporary worship music',
          'Biblical teaching and sermon',
          'Prayer and reflection time',
          'Fellowship with community members',
          'Children\'s programs available'
        ],
        rsvpLink: null,
        image: '/gradient-background.jpg'
      },
      {
        id: 2,
        title: 'Bible Study',
        description: 'Mid-week Bible study and prayer meeting for all ages.',
        fullDescription: 'Our mid-week Bible study provides an opportunity to dive deeper into God\'s Word in a small group setting. We explore biblical passages, discuss their application to daily life, and spend time in prayer together. This is a great way to grow in your understanding of Scripture and connect with others on a deeper level. All ages are welcome, and we provide separate groups for different life stages.',
        frequency: 'Wednesday',
        date: '2024-12-18',
        time: '7:00 PM',
        duration: '75 minutes',
        location: 'Fellowship Hall, Lippstadt',
        address: '123 Main Street, Lippstadt, Germany',
        contact: 'Sarah Johnson',
        contactEmail: 'biblestudy@cclippstadt.org',
        additionalInfo: 'Study materials provided. No prior Bible knowledge required.',
        whatToExpect: [
          'Interactive Bible study discussion',
          'Small group fellowship',
          'Prayer time',
          'Practical life application',
          'Questions and answers'
        ],
        rsvpLink: null,
        image: '/silky-waves.jpg'
      },
      {
        id: 3,
        title: 'Community Gathering',
        description: 'Monthly fellowship and community events for the whole family.',
        fullDescription: 'Our monthly community gatherings are special events designed to bring families together for fun, food, and fellowship. These events vary each month and may include potluck dinners, game nights, outdoor activities, service projects, or special celebrations. It\'s a wonderful opportunity to build relationships, have fun, and serve our community together.',
        frequency: 'Monthly',
        date: '2024-12-20',
        time: 'Various Times',
        duration: '2-3 hours',
        location: 'Community Center, Lippstadt',
        address: '456 Community Avenue, Lippstadt, Germany',
        contact: 'Event Coordinator',
        contactEmail: 'events@cclippstadt.org',
        additionalInfo: 'Check our calendar for specific dates and themes. Families welcome!',
        whatToExpect: [
          'Fun activities for all ages',
          'Delicious food and refreshments',
          'Community building',
          'Service opportunities',
          'Memorable experiences'
        ],
        rsvpLink: null,
        image: '/Warehouse-Air-Conditioners.jpg'
      }
    ])

    const filteredEvents = computed(() => {
      let filtered = events.value

      // Filter by location
      if (locationSearch.value.trim()) {
        const locationQuery = locationSearch.value.toLowerCase().trim()
        filtered = filtered.filter(event =>
          event.location.toLowerCase().includes(locationQuery)
        )
      }

      // Filter by keywords (search in title, description, frequency)
      if (keywordSearch.value.trim()) {
        const keywordQuery = keywordSearch.value.toLowerCase().trim()
        filtered = filtered.filter(event =>
          event.title.toLowerCase().includes(keywordQuery) ||
          event.description.toLowerCase().includes(keywordQuery) ||
          event.frequency.toLowerCase().includes(keywordQuery)
        )
      }

      return filtered
    })

    const clearFilters = () => {
      locationSearch.value = ''
      keywordSearch.value = ''
    }

    const formatDay = (dateString) => {
      if (!dateString) return ''
      const date = new Date(dateString)
      return date.getDate()
    }

    const formatMonth = (dateString) => {
      if (!dateString) return ''
      const date = new Date(dateString)
      return date.toLocaleDateString('en-US', { month: 'short' })
    }

    const openModal = (event) => {
      selectedEvent.value = event
      showModal.value = true
      // Prevent body scroll when modal is open
      document.body.style.overflow = 'hidden'
    }

    const closeModal = () => {
      showModal.value = false
      selectedEvent.value = null
      // Restore body scroll
      document.body.style.overflow = ''
    }

    const handleImageError = (event) => {
      console.error('Image failed to load:', event.target.src)
      const img = event.target
      // Add a visible error indicator
      img.style.backgroundColor = '#e5e7eb'
      img.style.display = 'flex'
      img.style.alignItems = 'center'
      img.style.justifyContent = 'center'
      // Try to load a fallback image if not already trying
      if (!img.dataset.fallbackAttempted) {
        img.dataset.fallbackAttempted = 'true'
        img.src = '/gradient-background.jpg'
      } else {
        // If fallback also fails, show error text
        img.alt = 'Image not available'
      }
    }

    const handleImageLoad = (event) => {
      console.log('Image loaded successfully:', event.target.src)
      // Reset any error styling
      event.target.style.backgroundColor = ''
      event.target.style.display = ''
      event.target.style.alignItems = ''
      event.target.style.justifyContent = ''
    }

    // Handle ESC key to close modal
    const handleEscape = (e) => {
      if (e.key === 'Escape' && showModal.value) {
        closeModal()
      }
    }

    onMounted(() => {
      window.addEventListener('keydown', handleEscape)
    })

    onUnmounted(() => {
      window.removeEventListener('keydown', handleEscape)
      // Ensure body scroll is restored if component unmounts with modal open
      document.body.style.overflow = ''
    })

    return {
      locationSearch,
      keywordSearch,
      events,
      filteredEvents,
      clearFilters,
      showModal,
      selectedEvent,
      openModal,
      closeModal,
      handleImageError,
      handleImageLoad,
      formatDay,
      formatMonth
    }
  }
}
</script>

<style scoped>
.events-hero {
  background-color: var(--brand-steelblue);
  position: relative;
  overflow: hidden;
}

.events-hero-background {
  background-image: url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

.events-hero-overlay {
  background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.5));
}

.event-card {
  transition: transform 0.3s ease;
}

.event-card:hover {
  transform: translateY(-4px);
}

.event-image {
  min-height: 12rem;
  position: relative;
}

.event-image img {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* Modal Styles */
.modal-overlay {
  animation: fadeIn 0.3s ease-out;
}

.modal-content {
  animation: slideUp 0.3s ease-out;
  max-height: 90vh;
}

.modal-header {
  flex-shrink: 0;
}

.modal-body {
  flex: 1 1 auto;
  min-height: 0;
}

.modal-footer {
  flex-shrink: 0;
}

/* Modal Transitions */
.modal-enter-active {
  transition: opacity 0.3s ease-out;
}

.modal-leave-active {
  transition: opacity 0.3s ease-in;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .modal-content {
  animation: slideUp 0.3s ease-out;
}

.modal-leave-active .modal-content {
  animation: slideDown 0.3s ease-in;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(30px) scale(0.95);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

@keyframes slideDown {
  from {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
  to {
    opacity: 0;
    transform: translateY(30px) scale(0.95);
  }
}

/* Custom Scrollbar for Modal Body */
.modal-body::-webkit-scrollbar {
  width: 8px;
}

.modal-body::-webkit-scrollbar-track {
  background: #f1f1f1;
}

.modal-body::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 4px;
}

.modal-body::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style>
