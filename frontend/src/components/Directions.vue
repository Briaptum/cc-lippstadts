<template>
  <section class="directions-section bg-gray-50 py-16 md:py-20">
    <div class="container mx-auto px-4 md:px-6">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-12 md:mb-16">
          <h2 class="text-3xl md:text-4xl lg:text-5xl font-bold text-brand-steelblue mb-4">
            Visit Us
          </h2>
          <div class="w-20 h-1 bg-brand-red mx-auto"></div>
        </div>
        
        <div class="grid lg:grid-cols-2 gap-8 lg:gap-12 items-center">
          <!-- Address and Info -->
          <div class="directions-info bg-white rounded-xl shadow-sm p-8 md:p-10">
            <div class="mb-8">
              <div class="mb-6">
                <div class="flex items-center gap-3 mb-4">
                  <svg class="w-5 h-5 text-brand-steelblue flex-shrink-0" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                  </svg>
                  <h3 class="text-xl md:text-2xl font-semibold text-brand-steelblue">Location</h3>
                </div>
                <address class="text-gray-600 text-base md:text-lg leading-relaxed not-italic ml-8">
                  Calvary Chapel Lippstadt<br>
                  [Street Address]<br>
                  Lippstadt, Germany
                </address>
              </div>
            </div>
            
            <a 
              href="https://maps.google.com" 
              target="_blank" 
              rel="noopener noreferrer"
              class="inline-flex items-center justify-center gap-3 bg-brand-red text-white px-8 py-4 rounded-lg hover:bg-opacity-90 transition-all duration-300 font-semibold text-base shadow-md hover:shadow-lg w-full md:w-auto"
            >
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7" />
              </svg>
              Get Directions on Google Maps
            </a>
          </div>
          
          <!-- Map -->
          <div class="directions-map">
            <div class="map-container bg-gray-200 rounded-xl overflow-hidden shadow-lg border border-gray-200" style="height: 450px;">
              <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2480.1234567890123!2d8.3456789!3d51.654321!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zNTHCsDM5JzE1LjYiTiA4wrAyMCc0NC40IkU!5e0!3m2!1sen!2sus!4v1234567890123!5m2!1sen!2sus"
                width="100%"
                height="100%"
                style="border:0;"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"
                class="w-full h-full"
              ></iframe>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Directions'
}
</script>

<style scoped>
.directions-section {
  background-color: #f9fafb;
}

.directions-info {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.directions-info:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}

.map-container {
  min-height: 450px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.map-container:hover {
  transform: translateY(-2px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.12);
}

@media (max-width: 1024px) {
  .map-container {
    height: 400px;
  }
}

@media (max-width: 768px) {
  .map-container {
    height: 350px;
  }
  
  .directions-info {
    padding: 1.5rem;
  }
}
</style>
