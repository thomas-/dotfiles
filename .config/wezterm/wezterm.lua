local wezterm = require 'wezterm'
-- Logging: wezterm.log_info 'log'
local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = 'SpaceGray Eighties'
-- config.color_scheme = 'OneDark (base16)'
-- config.bold_brightens_ansi_colors = 'No' -- change scheme and comment out

function scheme_for_env(env)
  if env == 'production' then
    return 'Red Alert'
  elseif env == 'staging' then
    -- return 'Ocean'
    return 'Nova (base16)'
  elseif env == 'ops' then
    -- return 'Belafonte Day'
    return 'Man Page'
  elseif env == 'error' then
    return 'Mono Red (Gogh)'
  end
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'SpaceGray Eighties'
    -- return 'nightfox'
  else
    return 'dawnfox'
    -- return 'Catppuccin Latte'
  end
end

-- Matches Ubuntu default terminal
config.font = wezterm.font('Ubuntu Mono')
config.font_size = 13.0
config.freetype_load_target = 'Light'
-- config.font =  wezterm.font('DejaVu Sans Mono', { weight = 'Book' }) -- vscode?

-- config.window_background_opacity = 0.9

-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
-- config.window_decorations = 'RESIZE'
-- config.window_decorations = 'TITLE|RESIZE'

-- use default window decorations?
config.enable_wayland = false 

-- fancy tab bar isn't themed by color schemes
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- scroll bar
config.enable_scroll_bar = true

-- keybinds
config.keys = {
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- light/dark mode follow system settings
wezterm.on('window-config-reloaded', function(window, pane)
  local env = pane:get_user_vars()['env']
  if env == nil or env == '' then -- only change scheme if env not overriding
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local scheme = scheme_for_appearance(appearance)
    if overrides.color_scheme ~= scheme then
      overrides.color_scheme = scheme
      window:set_config_overrides(overrides)
    end
  end
end)

-- change scheme depending on env
wezterm.on('user-var-changed', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local env = pane:get_user_vars()['env']
  local scheme = scheme_for_env(env) or scheme_for_appearance(window:get_appearance())
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

-- top right status info
local function segments_for_right_status(window, pane)
  local segments = {}
  local env = pane:get_user_vars()['env']
  if not (env == nil or env == '') then
    table.insert(segments, 'env: ' .. env)
  end
  -- table.insert(segments, wezterm.strftime('%a %b %-d %H:%M'))
  table.insert(segments, wezterm.hostname())
  return segments
end

wezterm.on('update-status', function(window, pane)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window, pane)

  local color_scheme = window:effective_config().resolved_palette
  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  local bg = wezterm.color.parse(color_scheme.background)
  local tab_bar_bg = wezterm.color.parse(color_scheme.tab_bar and color_scheme.tab_bar.background or '#333333')
  local fg = color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local appearance = window:get_appearance()
  local gradient_to, gradient_from = bg
    if appearance:find "Dark" then
      gradient_from = gradient_to:lighten(0.2)
    else
      gradient_from = gradient_to:darken(0.2)
    end

  -- Yes, WezTerm supports creating gradients, because why not?! Although
  -- they'd usually be used for setting high fidelity gradients on your terminal's
  -- background, we'll use them here to give us a sample of the powerline segment
  -- colours we need.
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      -- table.insert(elements, { Background = { Color = 'none' } })
      table.insert(elements, { Background = { Color = tab_bar_bg } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

return config
