<template>
  <div class="app-logo" :class="sizeClass">
    <span class="logo-text">
      <span class="logo-lex">Lex</span><span class="logo-ia">IA</span>
    </span>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(
  defineProps<{
    size?: 'small' | 'medium' | 'large'
  }>(),
  {
    size: 'medium'
  }
)

const sizeClass = computed(() => `size-${props.size}`)
</script>

<style scoped>
.app-logo {
  display: flex;
  align-items: center;
}

.logo-text {
  font-weight: 700;
  letter-spacing: -0.5px;
  display: inline-flex;
  align-items: baseline;
  gap: 1px;
}

.logo-lex {
  background: linear-gradient(135deg, #4b5563 0%, #374151 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.logo-ia {
  background: linear-gradient(135deg, var(--law-red-600) 0%, var(--law-red-800) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  font-weight: 800;
  position: relative;
  padding-bottom: 3px;
}

.logo-ia::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: linear-gradient(90deg, var(--law-red-600) 0%, var(--law-red-800) 100%);
  border-radius: 2px;
}

/* Size Variants */
.size-small .logo-text {
  font-size: 1.125rem;
}

.size-small .logo-ia::after {
  height: 1.5px;
}

.size-medium .logo-text {
  font-size: 1.35rem;
}

.size-medium .logo-ia::after {
  height: 2px;
}

.size-large .logo-text {
  font-size: 2rem;
}

.size-large .logo-ia::after {
  height: 3px;
}

/* Responsive */
@media (max-width: 768px) {
  .size-medium .logo-text {
    font-size: 1.15rem;
  }

  .size-medium .logo-ia::after {
    height: 1.5px;
  }
}

@media (max-width: 480px) {
  .size-medium .logo-text {
    font-size: 1rem;
  }

  .size-medium .logo-lex {
    display: none;
  }

  .size-medium .logo-ia::after {
    display: none;
  }
}
</style>
