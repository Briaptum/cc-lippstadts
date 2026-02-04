<template>
  <div>
    <Hero />
    <BibleVerse />
    <Directions />
  </div>
</template>

<script>
import Hero from '../components/Hero.vue'
import BibleVerse from '../components/BibleVerse.vue'
import Directions from '../components/Directions.vue'

export default {
  name: 'Home',
  components: {
    Hero,
    BibleVerse,
    Directions
  }
}
</script>
