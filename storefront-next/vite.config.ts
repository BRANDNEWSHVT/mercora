import vinext from "vinext";
import { fileURLToPath } from "node:url";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [vinext()],
  optimizeDeps: {
    exclude: ["@medusajs/ui", "radix-ui"],
  },
  resolve: {
    alias: {
      "radix-ui": fileURLToPath(
        new URL("./src/lib/radix-ui-shim.ts", import.meta.url)
      ),
      "use-sync-external-store/shim/index.js": fileURLToPath(
        new URL("./src/lib/use-sync-external-store-shim.ts", import.meta.url)
      ),
      "copy-to-clipboard": fileURLToPath(
        new URL("./src/lib/copy-to-clipboard-shim.ts", import.meta.url)
      ),
    },
  },
});
