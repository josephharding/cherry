//
//  game.h
//  cherry
//
//  Created by Joseph Harding on 1/27/18.
//  Copyright © 2018 Joseph Harding. All rights reserved.
//

#ifndef game_h
#define game_h

#include <iostream>
#include <vector>
#include <stdio.h>
#include <assert.h>

void on_surface_created();
void on_surface_changed();
void on_draw_frame();
void on_touch(float x, float y);

#endif /* game_h */
