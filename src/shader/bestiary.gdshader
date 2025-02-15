shader_type canvas_item;

uniform vec3 silhoutteColor : source_color = vec3(0,0,0);
uniform float mixT : hint_range(0.0, 1.0) = 0.5;


void fragment() {
COLOR.rgb = mix(COLOR.rgb, silhoutteColor, mixT);
}
