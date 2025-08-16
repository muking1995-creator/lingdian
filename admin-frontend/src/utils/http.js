import axios from 'axios'
const ins = axios.create({ baseURL: '/api' })
// 这里如需多租户，可在请求头加 X-Tenant
ins.interceptors.request.use(cfg => {
  // cfg.headers['X-Tenant'] = '1'
  return cfg
})
export default ins
