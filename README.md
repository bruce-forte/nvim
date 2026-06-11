# LazyVim Config

This is my specialized [LazyVim](https://github.com/LazyVim/LazyVim) configuration that solves some
issues that I had with LazyVim.

## Formtting

I find indenting with 2 spaces hard to read. This is usually configurable in the formatter
utilities, but in case of Go everything is set in stone, so I have to set the tab width instead.
You can see this in [options.lua](lua/config/options.lua)

> [!NOTE]
> I have to say here that this is how it is supposed to work for everything else as well.
> Use tabs and let the user set the tab width for themselves!

I also added `prettier` as the default formatter for html and json files as it was missing.

## Markdown preview

I've added configuration for markdown preview. This is very useful if you want to see it rendered
in the browser.

## Markdownlint disabled

The LazyVim `lang.markdown` extra wires `markdownlint-cli2` into four places (nvim-lint, conform,
none-ls, mason). I find its rules noisy, so [disable-markdownlint.lua](lua/plugins/disable-markdownlint.lua)
strips it from each list via `opts = function(_, opts)` overrides. Mason no longer auto-installs the
binary either. The rest of the markdown extra (render-markdown, marksman LSP, preview) stays intact.

## Themes

I'm using Catppuccin in my terminal and I have shortcuts for switching between light and dark.
Nvim supports Catppuccin so I've added configuration for the flavors (frappe and latte)
and an auto-loading feature that switches these whenever the terminal theme is switched.

I also trimmed the theme list in `all-themes.lua`.

## Bufferline always visible

Default LazyVim hides the bufferline when only one buffer is open. I prefer it always shown
so the tab strip doesn't pop in and out. Set via `always_show_bufferline = true` in
[bufferline.lua](lua/plugins/bufferline.lua).

## Trouble symbols auto-open

Symbols panel (Trouble) opens automatically on the right side on the first LSP attach, so I
get a code outline without manually toggling it. Width set to 20% of the screen.

- Autocmd: [autocmds.lua](lua/config/autocmds.lua)
- Width override: [trouble.lua](lua/plugins/trouble.lua)

## Neo-tree width

Explorer (neo-tree) width set to 20% of the screen at startup. Computed from `vim.o.columns`
in the plugin spec since neo-tree's `window.width` only accepts integer columns, not a
percentage. See [neo-tree.lua](lua/plugins/neo-tree.lua).
