import Alloy.C
open scoped Alloy.C

-- TODO try this with vanilla lean ffi instead of Alloy.

alloy c include <lean/lean.h> <stdint.h> <stdio.h> <unistd.h> 

alloy c include <SDL2/SDL.h>

alloy c section
#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480
end

alloy c extern
def createWindow : BaseIO Unit :=
  SDL_Window *window = NULL;
  SDL_Surface *screenSurface = NULL;
  if (SDL_Init(SDL_INIT_VIDEO) < 0) {
    -- fprintf(stderr, "could not initialize sdl2: %s\n", SDL_GetError());
    -- todo figure out how to print to stderr
    printf("could not initialize sdl2: %s\n", SDL_GetError());
    -- todo figure out how to return an error
    return lean_io_result_mk_ok(lean_box(0));
  }

  window = SDL_CreateWindow(
                "hello_sdl2",
                SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                SCREEN_WIDTH, SCREEN_HEIGHT,
                SDL_WINDOW_SHOWN
                );
  if (window == NULL) {
    -- todo figure out how to print to stderr
    -- fprintf(stderr, "could not create window: %s\n", SDL_GetError());
    printf("could not create window: %s\n", SDL_GetError());
    SDL_Quit();
    return lean_io_result_mk_ok(lean_box(0));
  }

  screenSurface = SDL_GetWindowSurface(window);
  SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format, 0xFF, 0xFF, 0xFF));
  SDL_UpdateWindowSurface(window);
  SDL_Delay(2000);
  SDL_DestroyWindow(window);
  SDL_Quit();
  return lean_io_result_mk_ok(lean_box(0));

alloy c extern
def myAdd (x y : UInt32) : UInt32 :=
  return x + y
