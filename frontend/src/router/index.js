import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/Home.vue'
import Events from '../pages/Events.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/events',
    name: 'Events',
    component: Events
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
