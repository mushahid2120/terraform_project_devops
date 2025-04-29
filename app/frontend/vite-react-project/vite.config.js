import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    'host': true,
    allowedHosts: [
      `${process.env.FRONTEND_LB_ENDPOINT}`,  
    ],
    proxy: {
      '/submit': {
        target: `http://${process.env.ALB_ENDPOINT}`,
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/submit/, '/submit'),
      },
      '/fetch': {
        target: `http://${process.env.ALB_ENDPOINT}`,
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/fetch/, '/fetch'),
      },
    },
  },
})
