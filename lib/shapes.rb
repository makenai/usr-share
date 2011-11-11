require 'prawn'

module Prawn
  module Graphics
    
    def square_shape
      fill do
        rectangle([36, 36], -27, 27)
      end
    end
    
    def x_shape
      save_graphics_state
      transformation_matrix(1, 0, 0, 1, 36, 14.3994)
      fill do
        move_to(0, 0)
        line_to(-8.1, 8.101)
        line_to(0, 16.201)
        line_to(-5.399, 21.601)
        line_to(-13.501, 13.501)
        line_to(-21.601, 21.601)
        line_to(-27, 16.201)
        line_to(-18.9, 8.101)
        line_to(-27, 0)
        line_to(-21.601, -5.399)
        line_to(-13.501, 2.7)
        line_to(-5.399, -5.399)
      end
      restore_graphics_state
    end    
    
    def plus_shape
      save_graphics_state
      transformation_matrix(1, 0, 0, 1, 37.7734, 26.3174)
      fill do
        move_to(0, 0)
        line_to(-11.455, 0.002)
        line_to(-11.455, 11.457)
        line_to(-19.092, 11.457)
        line_to(-19.092, 0)
        line_to(-30.547, 0)
        line_to(-30.547, -7.635)
        line_to(-19.092, -7.635)
        line_to(-19.092, -19.092)
        line_to(-11.455, -19.092)
        line_to(-11.455, -7.637)
        line_to(0, -7.635)
      end
      restore_graphics_state
    end    
    
    def triangle_shape
      save_graphics_state
      transformation_matrix(1, 0, 0, 1, 36, 10.8086)
      fill do
        move_to(0, 0)
        line_to(-13.5, 23.383)
        line_to(-27, 0)
      end
      restore_graphics_state
    end

    def circle_shape
      save_graphics_state
      save_graphics_state
      transformation_matrix(1, 0, 0, 1, 36, 22.5)
      fill do
        move_to(0, 0)
        curve_to([-13.5, -13.5], :bounds => [[0, -7.456], [-6.044, -13.5]])
        curve_to([-27, 0], :bounds => [[-20.956, -13.5], [-27, -7.456]])
        curve_to([-13.5, 13.5], :bounds => [[-27, 7.455], [-20.956, 13.5]])
        curve_to([0, 0], :bounds => [[-6.044, 13.5], [0, 7.455]])
      end
      restore_graphics_state
      restore_graphics_state
    end
    
    def diamond_shape
      save_graphics_state
      transformation_matrix(1, 0, 0, 1, 22.5, 9)
      fill do
        move_to(0, 0)
        line_to(-13.5, 13.5)
        line_to(0, 27)
        line_to(13.5, 13.5)
      end
      restore_graphics_state
    end        

  end
end