import { createRouter, createWebHistory } from 'vue-router'
import DemoOrders from '../pages/demo/DemoOrders.vue'
import JobIndex from '../pages/demo/JobIndex.vue'
const routes = [
  { path: '/', redirect:'/demo/orders' },
  { path: '/demo/orders', component: DemoOrders },
  { path: '/demo/jobs', component: JobIndex },
]
export default createRouter({ history: createWebHistory(), routes })
