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

## Themes

I'm using Catppuccin in my terminal and I have shortcuts for switching between light and dark.
Nvim supports Catppuccin so I've added configuration for the flavors (frappe and latte)
and an auto-loading feature that switches these whenever the terminal theme is switched.

I also trimmed the theme list in `all-themes.lua`.
