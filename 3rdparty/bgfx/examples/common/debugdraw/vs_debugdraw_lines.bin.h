static const uint8_t vs_debugdraw_lines_glsl[325] =
{
	0x56, 0x53, 0x48, 0x04, 0xa4, 0x8b, 0xef, 0x49, 0x01, 0x00, 0x0f, 0x75, 0x5f, 0x6d, 0x6f, 0x64, // VSH....I...u_mod
	0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x04, 0x01, 0x00, 0x00, 0x01, 0x00, // elViewProj......
	0x20, 0x01, 0x00, 0x00, 0x61, 0x74, 0x74, 0x72, 0x69, 0x62, 0x75, 0x74, 0x65, 0x20, 0x68, 0x69, //  ...attribute hi
	0x67, 0x68, 0x70, 0x20, 0x76, 0x65, 0x63, 0x34, 0x20, 0x61, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, 0x72, // ghp vec4 a_color
	0x30, 0x3b, 0x0a, 0x61, 0x74, 0x74, 0x72, 0x69, 0x62, 0x75, 0x74, 0x65, 0x20, 0x68, 0x69, 0x67, // 0;.attribute hig
	0x68, 0x70, 0x20, 0x76, 0x65, 0x63, 0x33, 0x20, 0x61, 0x5f, 0x70, 0x6f, 0x73, 0x69, 0x74, 0x69, // hp vec3 a_positi
	0x6f, 0x6e, 0x3b, 0x0a, 0x76, 0x61, 0x72, 0x79, 0x69, 0x6e, 0x67, 0x20, 0x68, 0x69, 0x67, 0x68, // on;.varying high
	0x70, 0x20, 0x76, 0x65, 0x63, 0x34, 0x20, 0x76, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x30, 0x3b, // p vec4 v_color0;
	0x0a, 0x75, 0x6e, 0x69, 0x66, 0x6f, 0x72, 0x6d, 0x20, 0x68, 0x69, 0x67, 0x68, 0x70, 0x20, 0x6d, // .uniform highp m
	0x61, 0x74, 0x34, 0x20, 0x75, 0x5f, 0x6d, 0x6f, 0x64, 0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, // at4 u_modelViewP
	0x72, 0x6f, 0x6a, 0x3b, 0x0a, 0x76, 0x6f, 0x69, 0x64, 0x20, 0x6d, 0x61, 0x69, 0x6e, 0x20, 0x28, // roj;.void main (
	0x29, 0x0a, 0x7b, 0x0a, 0x20, 0x20, 0x68, 0x69, 0x67, 0x68, 0x70, 0x20, 0x76, 0x65, 0x63, 0x34, // ).{.  highp vec4
	0x20, 0x74, 0x6d, 0x70, 0x76, 0x61, 0x72, 0x5f, 0x31, 0x3b, 0x0a, 0x20, 0x20, 0x74, 0x6d, 0x70, //  tmpvar_1;.  tmp
	0x76, 0x61, 0x72, 0x5f, 0x31, 0x2e, 0x77, 0x20, 0x3d, 0x20, 0x31, 0x2e, 0x30, 0x3b, 0x0a, 0x20, // var_1.w = 1.0;. 
	0x20, 0x74, 0x6d, 0x70, 0x76, 0x61, 0x72, 0x5f, 0x31, 0x2e, 0x78, 0x79, 0x7a, 0x20, 0x3d, 0x20, //  tmpvar_1.xyz = 
	0x61, 0x5f, 0x70, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x3b, 0x0a, 0x20, 0x20, 0x67, 0x6c, // a_position;.  gl
	0x5f, 0x50, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x3d, 0x20, 0x28, 0x75, 0x5f, 0x6d, // _Position = (u_m
	0x6f, 0x64, 0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x20, 0x2a, 0x20, 0x74, // odelViewProj * t
	0x6d, 0x70, 0x76, 0x61, 0x72, 0x5f, 0x31, 0x29, 0x3b, 0x0a, 0x20, 0x20, 0x76, 0x5f, 0x63, 0x6f, // mpvar_1);.  v_co
	0x6c, 0x6f, 0x72, 0x30, 0x20, 0x3d, 0x20, 0x61, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x30, 0x3b, // lor0 = a_color0;
	0x0a, 0x7d, 0x0a, 0x0a, 0x00,                                                                   // .}...
};
static const uint8_t vs_debugdraw_lines_spv[2763] =
{
	0x56, 0x53, 0x48, 0x04, 0xa4, 0x8b, 0xef, 0x49, 0x01, 0x00, 0x0f, 0x75, 0x5f, 0x6d, 0x6f, 0x64, // VSH....I...u_mod
	0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x04, 0x01, 0x00, 0x00, 0x01, 0x00, // elViewProj......
	0xa8, 0x0a, 0x03, 0x02, 0x23, 0x07, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x08, 0x00, 0x54, 0x61, // ....#.........Ta
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x11, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x0b, 0x00, // ................
	0x06, 0x00, 0x01, 0x00, 0x00, 0x00, 0x47, 0x4c, 0x53, 0x4c, 0x2e, 0x73, 0x74, 0x64, 0x2e, 0x34, // ......GLSL.std.4
	0x35, 0x30, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, // 50..............
	0x00, 0x00, 0x0f, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x16, 0x00, 0x00, 0x6d, 0x61, // ..............ma
	0x69, 0x6e, 0x00, 0x00, 0x00, 0x00, 0x89, 0x14, 0x00, 0x00, 0xa6, 0x14, 0x00, 0x00, 0xd8, 0x0c, // in..............
	0x00, 0x00, 0xcd, 0x0f, 0x00, 0x00, 0x05, 0x00, 0x04, 0x00, 0x1f, 0x16, 0x00, 0x00, 0x6d, 0x61, // ..............ma
	0x69, 0x6e, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x04, 0x00, 0x38, 0x04, 0x00, 0x00, 0x4f, 0x75, // in........8...Ou
	0x74, 0x70, 0x75, 0x74, 0x00, 0x00, 0x06, 0x00, 0x06, 0x00, 0x38, 0x04, 0x00, 0x00, 0x00, 0x00, // tput......8.....
	0x00, 0x00, 0x67, 0x6c, 0x5f, 0x50, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x00, 0x06, 0x00, // ..gl_Position...
	0x06, 0x00, 0x38, 0x04, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x76, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, // ..8.......v_colo
	0x72, 0x30, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x06, 0x00, 0x0e, 0x0c, 0x00, 0x00, 0x40, 0x6d, // r0............@m
	0x61, 0x69, 0x6e, 0x28, 0x76, 0x66, 0x34, 0x3b, 0x76, 0x66, 0x33, 0x3b, 0x00, 0x00, 0x05, 0x00, // ain(vf4;vf3;....
	0x05, 0x00, 0xf5, 0x48, 0x00, 0x00, 0x61, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x30, 0x00, 0x00, // ...H..a_color0..
	0x00, 0x00, 0x05, 0x00, 0x05, 0x00, 0x2c, 0x47, 0x00, 0x00, 0x61, 0x5f, 0x70, 0x6f, 0x73, 0x69, // ......,G..a_posi
	0x74, 0x69, 0x6f, 0x6e, 0x00, 0x00, 0x05, 0x00, 0x05, 0x00, 0x0f, 0x12, 0x00, 0x00, 0x5f, 0x76, // tion.........._v
	0x61, 0x72, 0x79, 0x69, 0x6e, 0x67, 0x5f, 0x00, 0x00, 0x00, 0x05, 0x00, 0x04, 0x00, 0x99, 0x02, // arying_.........
	0x00, 0x00, 0x24, 0x47, 0x6c, 0x6f, 0x62, 0x61, 0x6c, 0x00, 0x06, 0x00, 0x06, 0x00, 0x99, 0x02, // ..$Global.......
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x75, 0x5f, 0x76, 0x69, 0x65, 0x77, 0x52, 0x65, 0x63, 0x74, // ......u_viewRect
	0x00, 0x00, 0x06, 0x00, 0x06, 0x00, 0x99, 0x02, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x75, 0x5f, // ..............u_
	0x76, 0x69, 0x65, 0x77, 0x54, 0x65, 0x78, 0x65, 0x6c, 0x00, 0x06, 0x00, 0x05, 0x00, 0x99, 0x02, // viewTexel.......
	0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x75, 0x5f, 0x76, 0x69, 0x65, 0x77, 0x00, 0x00, 0x06, 0x00, // ......u_view....
	0x06, 0x00, 0x99, 0x02, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x75, 0x5f, 0x69, 0x6e, 0x76, 0x56, // ..........u_invV
	0x69, 0x65, 0x77, 0x00, 0x00, 0x00, 0x06, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x04, 0x00, // iew.............
	0x00, 0x00, 0x75, 0x5f, 0x70, 0x72, 0x6f, 0x6a, 0x00, 0x00, 0x06, 0x00, 0x06, 0x00, 0x99, 0x02, // ..u_proj........
	0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x75, 0x5f, 0x69, 0x6e, 0x76, 0x50, 0x72, 0x6f, 0x6a, 0x00, // ......u_invProj.
	0x00, 0x00, 0x06, 0x00, 0x06, 0x00, 0x99, 0x02, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x75, 0x5f, // ..............u_
	0x76, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x00, 0x00, 0x06, 0x00, 0x07, 0x00, 0x99, 0x02, // viewProj........
	0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x75, 0x5f, 0x69, 0x6e, 0x76, 0x56, 0x69, 0x65, 0x77, 0x50, // ......u_invViewP
	0x72, 0x6f, 0x6a, 0x00, 0x00, 0x00, 0x06, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x08, 0x00, // roj.............
	0x00, 0x00, 0x75, 0x5f, 0x6d, 0x6f, 0x64, 0x65, 0x6c, 0x00, 0x06, 0x00, 0x06, 0x00, 0x99, 0x02, // ..u_model.......
	0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x75, 0x5f, 0x6d, 0x6f, 0x64, 0x65, 0x6c, 0x56, 0x69, 0x65, // ......u_modelVie
	0x77, 0x00, 0x06, 0x00, 0x07, 0x00, 0x99, 0x02, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x75, 0x5f, // w.............u_
	0x6d, 0x6f, 0x64, 0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x00, 0x06, 0x00, // modelViewProj...
	0x06, 0x00, 0x99, 0x02, 0x00, 0x00, 0x0b, 0x00, 0x00, 0x00, 0x75, 0x5f, 0x61, 0x6c, 0x70, 0x68, // ..........u_alph
	0x61, 0x52, 0x65, 0x66, 0x34, 0x00, 0x05, 0x00, 0x03, 0x00, 0x42, 0x13, 0x00, 0x00, 0x00, 0x00, // aRef4.....B.....
	0x00, 0x00, 0x05, 0x00, 0x05, 0x00, 0xcb, 0x41, 0x00, 0x00, 0x61, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, // .......A..a_colo
	0x72, 0x30, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x05, 0x00, 0x89, 0x14, 0x00, 0x00, 0x61, 0x5f, // r0............a_
	0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x30, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x05, 0x00, 0x2c, 0x3f, // color0........,?
	0x00, 0x00, 0x61, 0x5f, 0x70, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x00, 0x00, 0x05, 0x00, // ..a_position....
	0x05, 0x00, 0xa6, 0x14, 0x00, 0x00, 0x61, 0x5f, 0x70, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, // ......a_position
	0x00, 0x00, 0x05, 0x00, 0x05, 0x00, 0x08, 0x10, 0x00, 0x00, 0x66, 0x6c, 0x61, 0x74, 0x74, 0x65, // ..........flatte
	0x6e, 0x54, 0x65, 0x6d, 0x70, 0x00, 0x05, 0x00, 0x04, 0x00, 0xab, 0x55, 0x00, 0x00, 0x70, 0x61, // nTemp......U..pa
	0x72, 0x61, 0x6d, 0x00, 0x00, 0x00, 0x05, 0x00, 0x04, 0x00, 0x9a, 0x16, 0x00, 0x00, 0x70, 0x61, // ram...........pa
	0x72, 0x61, 0x6d, 0x00, 0x00, 0x00, 0x05, 0x00, 0x0a, 0x00, 0xd8, 0x0c, 0x00, 0x00, 0x40, 0x65, // ram...........@e
	0x6e, 0x74, 0x72, 0x79, 0x50, 0x6f, 0x69, 0x6e, 0x74, 0x4f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x5f, // ntryPointOutput_
	0x67, 0x6c, 0x5f, 0x50, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x00, 0x00, 0x00, 0x05, 0x00, // gl_Position.....
	0x04, 0x00, 0xf9, 0x03, 0x00, 0x00, 0x4f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x00, 0x00, 0x06, 0x00, // ......Output....
	0x06, 0x00, 0xf9, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, // ..........v_colo
	0x72, 0x30, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x07, 0x00, 0xcd, 0x0f, 0x00, 0x00, 0x40, 0x65, // r0............@e
	0x6e, 0x74, 0x72, 0x79, 0x50, 0x6f, 0x69, 0x6e, 0x74, 0x4f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x00, // ntryPointOutput.
	0x00, 0x00, 0x47, 0x00, 0x04, 0x00, 0x37, 0x02, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x40, 0x00, // ..G...7.......@.
	0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x23, 0x00, // ..H...........#.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x01, 0x00, // ......H.........
	0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, // ..#.......H.....
	0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x48, 0x00, // ......#... ...H.
	0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, // ................
	0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, // ..H.............
	0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x23, 0x00, // ..H...........#.
	0x00, 0x00, 0x60, 0x00, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x03, 0x00, // ..`...H.........
	0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0xa0, 0x00, 0x00, 0x00, 0x48, 0x00, // ......#.......H.
	0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, // ................
	0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04, 0x00, // ..H.............
	0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x23, 0x00, // ..H...........#.
	0x00, 0x00, 0xe0, 0x00, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x05, 0x00, // ......H.........
	0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0x20, 0x01, 0x00, 0x00, 0x48, 0x00, // ......#... ...H.
	0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, // ................
	0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x04, 0x00, // ..H.............
	0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x23, 0x00, // ..H...........#.
	0x00, 0x00, 0x60, 0x01, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x07, 0x00, // ..`...H.........
	0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0xa0, 0x01, 0x00, 0x00, 0x48, 0x00, // ......#.......H.
	0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, // ................
	0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x04, 0x00, // ..H.............
	0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x23, 0x00, // ..H...........#.
	0x00, 0x00, 0xa0, 0x09, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x09, 0x00, // ......H.........
	0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x48, 0x00, 0x04, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, // ..........H.....
	0x00, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0xe0, 0x09, 0x00, 0x00, 0x48, 0x00, // ......#.......H.
	0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x10, 0x00, // ................
	0x00, 0x00, 0x48, 0x00, 0x05, 0x00, 0x99, 0x02, 0x00, 0x00, 0x0b, 0x00, 0x00, 0x00, 0x23, 0x00, // ..H...........#.
	0x00, 0x00, 0x20, 0x0a, 0x00, 0x00, 0x47, 0x00, 0x03, 0x00, 0x99, 0x02, 0x00, 0x00, 0x02, 0x00, // .. ...G.........
	0x00, 0x00, 0x47, 0x00, 0x04, 0x00, 0x42, 0x13, 0x00, 0x00, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, // ..G...B...".....
	0x00, 0x00, 0x47, 0x00, 0x04, 0x00, 0x89, 0x14, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, // ..G.............
	0x00, 0x00, 0x47, 0x00, 0x04, 0x00, 0xa6, 0x14, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x01, 0x00, // ..G.............
	0x00, 0x00, 0x47, 0x00, 0x04, 0x00, 0xd8, 0x0c, 0x00, 0x00, 0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, // ..G.............
	0x00, 0x00, 0x47, 0x00, 0x04, 0x00, 0xcd, 0x0f, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, // ..G.............
	0x00, 0x00, 0x13, 0x00, 0x02, 0x00, 0x08, 0x00, 0x00, 0x00, 0x21, 0x00, 0x03, 0x00, 0x02, 0x05, // ..........!.....
	0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x16, 0x00, 0x03, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x20, 0x00, // .............. .
	0x00, 0x00, 0x17, 0x00, 0x04, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x04, 0x00, // ................
	0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0x9a, 0x02, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x1d, 0x00, // .. .............
	0x00, 0x00, 0x17, 0x00, 0x04, 0x00, 0x18, 0x00, 0x00, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x03, 0x00, // ................
	0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0x95, 0x02, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x18, 0x00, // .. .............
	0x00, 0x00, 0x1e, 0x00, 0x04, 0x00, 0x38, 0x04, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x1d, 0x00, // ......8.........
	0x00, 0x00, 0x21, 0x00, 0x05, 0x00, 0xc6, 0x07, 0x00, 0x00, 0x38, 0x04, 0x00, 0x00, 0x9a, 0x02, // ..!.......8.....
	0x00, 0x00, 0x95, 0x02, 0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0xb5, 0x06, 0x00, 0x00, 0x07, 0x00, // ...... .........
	0x00, 0x00, 0x38, 0x04, 0x00, 0x00, 0x15, 0x00, 0x04, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x20, 0x00, // ..8........... .
	0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x2b, 0x00, 0x04, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x0e, 0x0a, // ......+.........
	0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x2b, 0x00, 0x04, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x8a, 0x00, // ......+.........
	0x00, 0x00, 0x00, 0x00, 0x80, 0x3f, 0x2b, 0x00, 0x04, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x0c, 0x0a, // .....?+.........
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2c, 0x00, 0x07, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x88, 0x05, // ......,.........
	0x00, 0x00, 0x8a, 0x00, 0x00, 0x00, 0x0c, 0x0a, 0x00, 0x00, 0x0c, 0x0a, 0x00, 0x00, 0x8a, 0x00, // ................
	0x00, 0x00, 0x2b, 0x00, 0x04, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x0b, 0x0a, 0x00, 0x00, 0x00, 0x00, // ..+.............
	0x00, 0x00, 0x18, 0x00, 0x04, 0x00, 0x65, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x04, 0x00, // ......e.........
	0x00, 0x00, 0x15, 0x00, 0x04, 0x00, 0x0b, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, // .......... .....
	0x00, 0x00, 0x2b, 0x00, 0x04, 0x00, 0x0b, 0x00, 0x00, 0x00, 0x6a, 0x0a, 0x00, 0x00, 0x20, 0x00, // ..+.......j... .
	0x00, 0x00, 0x1c, 0x00, 0x04, 0x00, 0x37, 0x02, 0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x6a, 0x0a, // ......7...e...j.
	0x00, 0x00, 0x1e, 0x00, 0x0e, 0x00, 0x99, 0x02, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x1d, 0x00, // ................
	0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x65, 0x00, // ..e...e...e...e.
	0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x37, 0x02, 0x00, 0x00, 0x65, 0x00, // ..e...e...7...e.
	0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0x16, 0x05, // ..e....... .....
	0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x99, 0x02, 0x00, 0x00, 0x3b, 0x00, 0x04, 0x00, 0x16, 0x05, // ..........;.....
	0x00, 0x00, 0x42, 0x13, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x2b, 0x00, 0x04, 0x00, 0x0c, 0x00, // ..B.......+.....
	0x00, 0x00, 0x29, 0x0a, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0xe2, 0x02, // ..)....... .....
	0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0x9b, 0x02, // ......e... .....
	0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x3b, 0x00, 0x04, 0x00, 0x9b, 0x02, // ..........;.....
	0x00, 0x00, 0x89, 0x14, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0x96, 0x02, // .......... .....
	0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00, 0x00, 0x3b, 0x00, 0x04, 0x00, 0x96, 0x02, // ..........;.....
	0x00, 0x00, 0xa6, 0x14, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0x9c, 0x02, // .......... .....
	0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x3b, 0x00, 0x04, 0x00, 0x9c, 0x02, // ..........;.....
	0x00, 0x00, 0xd8, 0x0c, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x1e, 0x00, 0x03, 0x00, 0xf9, 0x03, // ................
	0x00, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x20, 0x00, 0x04, 0x00, 0x76, 0x06, 0x00, 0x00, 0x03, 0x00, // ...... ...v.....
	0x00, 0x00, 0xf9, 0x03, 0x00, 0x00, 0x3b, 0x00, 0x04, 0x00, 0x76, 0x06, 0x00, 0x00, 0xcd, 0x0f, // ......;...v.....
	0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x36, 0x00, 0x05, 0x00, 0x08, 0x00, 0x00, 0x00, 0x1f, 0x16, // ......6.........
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0xf8, 0x00, 0x02, 0x00, 0x53, 0x61, // ..............Sa
	0x00, 0x00, 0x3b, 0x00, 0x04, 0x00, 0xb5, 0x06, 0x00, 0x00, 0x08, 0x10, 0x00, 0x00, 0x07, 0x00, // ..;.............
	0x00, 0x00, 0x3b, 0x00, 0x04, 0x00, 0x9a, 0x02, 0x00, 0x00, 0xab, 0x55, 0x00, 0x00, 0x07, 0x00, // ..;........U....
	0x00, 0x00, 0x3b, 0x00, 0x04, 0x00, 0x95, 0x02, 0x00, 0x00, 0x9a, 0x16, 0x00, 0x00, 0x07, 0x00, // ..;.............
	0x00, 0x00, 0x3d, 0x00, 0x04, 0x00, 0x1d, 0x00, 0x00, 0x00, 0xcb, 0x41, 0x00, 0x00, 0x89, 0x14, // ..=........A....
	0x00, 0x00, 0x3d, 0x00, 0x04, 0x00, 0x18, 0x00, 0x00, 0x00, 0x2c, 0x3f, 0x00, 0x00, 0xa6, 0x14, // ..=.......,?....
	0x00, 0x00, 0x3e, 0x00, 0x03, 0x00, 0xab, 0x55, 0x00, 0x00, 0xcb, 0x41, 0x00, 0x00, 0x3e, 0x00, // ..>....U...A..>.
	0x03, 0x00, 0x9a, 0x16, 0x00, 0x00, 0x2c, 0x3f, 0x00, 0x00, 0x39, 0x00, 0x06, 0x00, 0x38, 0x04, // ......,?..9...8.
	0x00, 0x00, 0x49, 0x26, 0x00, 0x00, 0x0e, 0x0c, 0x00, 0x00, 0xab, 0x55, 0x00, 0x00, 0x9a, 0x16, // ..I&.......U....
	0x00, 0x00, 0x3e, 0x00, 0x03, 0x00, 0x08, 0x10, 0x00, 0x00, 0x49, 0x26, 0x00, 0x00, 0x41, 0x00, // ..>.......I&..A.
	0x05, 0x00, 0x9a, 0x02, 0x00, 0x00, 0x54, 0x34, 0x00, 0x00, 0x08, 0x10, 0x00, 0x00, 0x0b, 0x0a, // ......T4........
	0x00, 0x00, 0x3d, 0x00, 0x04, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x00, 0x00, 0x54, 0x34, // ..=...........T4
	0x00, 0x00, 0x3e, 0x00, 0x03, 0x00, 0xd8, 0x0c, 0x00, 0x00, 0x1f, 0x1f, 0x00, 0x00, 0x41, 0x00, // ..>...........A.
	0x05, 0x00, 0x9a, 0x02, 0x00, 0x00, 0x27, 0x41, 0x00, 0x00, 0x08, 0x10, 0x00, 0x00, 0x0e, 0x0a, // ......'A........
	0x00, 0x00, 0x3d, 0x00, 0x04, 0x00, 0x1d, 0x00, 0x00, 0x00, 0xdf, 0x1c, 0x00, 0x00, 0x27, 0x41, // ..=...........'A
	0x00, 0x00, 0x41, 0x00, 0x05, 0x00, 0x9c, 0x02, 0x00, 0x00, 0x01, 0x5c, 0x00, 0x00, 0xcd, 0x0f, // ..A.............
	0x00, 0x00, 0x0b, 0x0a, 0x00, 0x00, 0x3e, 0x00, 0x03, 0x00, 0x01, 0x5c, 0x00, 0x00, 0xdf, 0x1c, // ......>.........
	0x00, 0x00, 0xfd, 0x00, 0x01, 0x00, 0x38, 0x00, 0x01, 0x00, 0x36, 0x00, 0x05, 0x00, 0x38, 0x04, // ......8...6...8.
	0x00, 0x00, 0x0e, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc6, 0x07, 0x00, 0x00, 0x37, 0x00, // ..............7.
	0x03, 0x00, 0x9a, 0x02, 0x00, 0x00, 0xf5, 0x48, 0x00, 0x00, 0x37, 0x00, 0x03, 0x00, 0x95, 0x02, // .......H..7.....
	0x00, 0x00, 0x2c, 0x47, 0x00, 0x00, 0xf8, 0x00, 0x02, 0x00, 0x51, 0x1d, 0x00, 0x00, 0x3b, 0x00, // ..,G......Q...;.
	0x04, 0x00, 0xb5, 0x06, 0x00, 0x00, 0x0f, 0x12, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x41, 0x00, // ..............A.
	0x05, 0x00, 0x9a, 0x02, 0x00, 0x00, 0x50, 0x24, 0x00, 0x00, 0x0f, 0x12, 0x00, 0x00, 0x0e, 0x0a, // ......P$........
	0x00, 0x00, 0x3e, 0x00, 0x03, 0x00, 0x50, 0x24, 0x00, 0x00, 0x88, 0x05, 0x00, 0x00, 0x3d, 0x00, // ..>...P$......=.
	0x04, 0x00, 0x18, 0x00, 0x00, 0x00, 0x27, 0x28, 0x00, 0x00, 0x2c, 0x47, 0x00, 0x00, 0x51, 0x00, // ......'(..,G..Q.
	0x05, 0x00, 0x0d, 0x00, 0x00, 0x00, 0xac, 0x4a, 0x00, 0x00, 0x27, 0x28, 0x00, 0x00, 0x00, 0x00, // .......J..'(....
	0x00, 0x00, 0x51, 0x00, 0x05, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x7c, 0x57, 0x00, 0x00, 0x27, 0x28, // ..Q.......|W..'(
	0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x51, 0x00, 0x05, 0x00, 0x0d, 0x00, 0x00, 0x00, 0x1d, 0x19, // ......Q.........
	0x00, 0x00, 0x27, 0x28, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x50, 0x00, 0x07, 0x00, 0x1d, 0x00, // ..'(......P.....
	0x00, 0x00, 0xf5, 0x42, 0x00, 0x00, 0xac, 0x4a, 0x00, 0x00, 0x7c, 0x57, 0x00, 0x00, 0x1d, 0x19, // ...B...J..|W....
	0x00, 0x00, 0x8a, 0x00, 0x00, 0x00, 0x41, 0x00, 0x05, 0x00, 0xe2, 0x02, 0x00, 0x00, 0x61, 0x23, // ......A.......a#
	0x00, 0x00, 0x42, 0x13, 0x00, 0x00, 0x29, 0x0a, 0x00, 0x00, 0x3d, 0x00, 0x04, 0x00, 0x65, 0x00, // ..B...)...=...e.
	0x00, 0x00, 0x2b, 0x34, 0x00, 0x00, 0x61, 0x23, 0x00, 0x00, 0x90, 0x00, 0x05, 0x00, 0x1d, 0x00, // ..+4..a#........
	0x00, 0x00, 0xd7, 0x32, 0x00, 0x00, 0xf5, 0x42, 0x00, 0x00, 0x2b, 0x34, 0x00, 0x00, 0x41, 0x00, // ...2...B..+4..A.
	0x05, 0x00, 0x9a, 0x02, 0x00, 0x00, 0x97, 0x2f, 0x00, 0x00, 0x0f, 0x12, 0x00, 0x00, 0x0b, 0x0a, // ......./........
	0x00, 0x00, 0x3e, 0x00, 0x03, 0x00, 0x97, 0x2f, 0x00, 0x00, 0xd7, 0x32, 0x00, 0x00, 0x3d, 0x00, // ..>..../...2..=.
	0x04, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x8e, 0x31, 0x00, 0x00, 0xf5, 0x48, 0x00, 0x00, 0x41, 0x00, // .......1...H..A.
	0x05, 0x00, 0x9a, 0x02, 0x00, 0x00, 0x9e, 0x4c, 0x00, 0x00, 0x0f, 0x12, 0x00, 0x00, 0x0e, 0x0a, // .......L........
	0x00, 0x00, 0x3e, 0x00, 0x03, 0x00, 0x9e, 0x4c, 0x00, 0x00, 0x8e, 0x31, 0x00, 0x00, 0x3d, 0x00, // ..>....L...1..=.
	0x04, 0x00, 0x38, 0x04, 0x00, 0x00, 0x30, 0x19, 0x00, 0x00, 0x0f, 0x12, 0x00, 0x00, 0xfe, 0x00, // ..8...0.........
	0x02, 0x00, 0x30, 0x19, 0x00, 0x00, 0x38, 0x00, 0x01, 0x00, 0x00,                               // ..0...8....
};
static const uint8_t vs_debugdraw_lines_dx9[311] =
{
	0x56, 0x53, 0x48, 0x04, 0xa4, 0x8b, 0xef, 0x49, 0x01, 0x00, 0x0f, 0x75, 0x5f, 0x6d, 0x6f, 0x64, // VSH....I...u_mod
	0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x04, 0x01, 0x00, 0x00, 0x04, 0x00, // elViewProj......
	0x14, 0x01, 0x00, 0x03, 0xfe, 0xff, 0xfe, 0xff, 0x21, 0x00, 0x43, 0x54, 0x41, 0x42, 0x1c, 0x00, // ........!.CTAB..
	0x00, 0x00, 0x57, 0x00, 0x00, 0x00, 0x00, 0x03, 0xfe, 0xff, 0x01, 0x00, 0x00, 0x00, 0x1c, 0x00, // ..W.............
	0x00, 0x00, 0x00, 0x91, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x02, 0x00, // ......P...0.....
	0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x75, 0x5f, // ......@.......u_
	0x6d, 0x6f, 0x64, 0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x00, 0x03, 0x00, // modelViewProj...
	0x03, 0x00, 0x04, 0x00, 0x04, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0x73, // ..............vs
	0x5f, 0x33, 0x5f, 0x30, 0x00, 0x4d, 0x69, 0x63, 0x72, 0x6f, 0x73, 0x6f, 0x66, 0x74, 0x20, 0x28, // _3_0.Microsoft (
	0x52, 0x29, 0x20, 0x48, 0x4c, 0x53, 0x4c, 0x20, 0x53, 0x68, 0x61, 0x64, 0x65, 0x72, 0x20, 0x43, // R) HLSL Shader C
	0x6f, 0x6d, 0x70, 0x69, 0x6c, 0x65, 0x72, 0x20, 0x31, 0x30, 0x2e, 0x31, 0x00, 0xab, 0x1f, 0x00, // ompiler 10.1....
	0x00, 0x02, 0x0a, 0x00, 0x00, 0x80, 0x00, 0x00, 0x0f, 0x90, 0x1f, 0x00, 0x00, 0x02, 0x00, 0x00, // ................
	0x00, 0x80, 0x01, 0x00, 0x0f, 0x90, 0x1f, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, // ................
	0x0f, 0xe0, 0x1f, 0x00, 0x00, 0x02, 0x0a, 0x00, 0x00, 0x80, 0x01, 0x00, 0x0f, 0xe0, 0x05, 0x00, // ................
	0x00, 0x03, 0x00, 0x00, 0x0f, 0x80, 0x01, 0x00, 0xe4, 0xa0, 0x01, 0x00, 0x55, 0x90, 0x04, 0x00, // ............U...
	0x00, 0x04, 0x00, 0x00, 0x0f, 0x80, 0x00, 0x00, 0xe4, 0xa0, 0x01, 0x00, 0x00, 0x90, 0x00, 0x00, // ................
	0xe4, 0x80, 0x04, 0x00, 0x00, 0x04, 0x00, 0x00, 0x0f, 0x80, 0x02, 0x00, 0xe4, 0xa0, 0x01, 0x00, // ................
	0xaa, 0x90, 0x00, 0x00, 0xe4, 0x80, 0x02, 0x00, 0x00, 0x03, 0x00, 0x00, 0x0f, 0xe0, 0x00, 0x00, // ................
	0xe4, 0x80, 0x03, 0x00, 0xe4, 0xa0, 0x01, 0x00, 0x00, 0x02, 0x01, 0x00, 0x0f, 0xe0, 0x00, 0x00, // ................
	0xe4, 0x90, 0xff, 0xff, 0x00, 0x00, 0x00,                                                       // .......
};
static const uint8_t vs_debugdraw_lines_dx11[510] =
{
	0x56, 0x53, 0x48, 0x04, 0xa4, 0x8b, 0xef, 0x49, 0x01, 0x00, 0x0f, 0x75, 0x5f, 0x6d, 0x6f, 0x64, // VSH....I...u_mod
	0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, // elViewProj......
	0xd4, 0x01, 0x44, 0x58, 0x42, 0x43, 0x32, 0x9b, 0xdd, 0xb5, 0xa9, 0xb7, 0x22, 0xf0, 0xcf, 0x5e, // ..DXBC2....."..^
	0x34, 0x2c, 0x72, 0xf0, 0x87, 0x00, 0x01, 0x00, 0x00, 0x00, 0xd4, 0x01, 0x00, 0x00, 0x03, 0x00, // 4,r.............
	0x00, 0x00, 0x2c, 0x00, 0x00, 0x00, 0x7c, 0x00, 0x00, 0x00, 0xd0, 0x00, 0x00, 0x00, 0x49, 0x53, // ..,...|.......IS
	0x47, 0x4e, 0x48, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x38, 0x00, // GNH...........8.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, // ................
	0x00, 0x00, 0x0f, 0x0f, 0x00, 0x00, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // ......>.........
	0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x07, 0x07, 0x00, 0x00, 0x43, 0x4f, // ..............CO
	0x4c, 0x4f, 0x52, 0x00, 0x50, 0x4f, 0x53, 0x49, 0x54, 0x49, 0x4f, 0x4e, 0x00, 0xab, 0x4f, 0x53, // LOR.POSITION..OS
	0x47, 0x4e, 0x4c, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x38, 0x00, // GNL...........8.
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, // ................
	0x00, 0x00, 0x0f, 0x00, 0x00, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // ......D.........
	0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x0f, 0x00, 0x00, 0x00, 0x53, 0x56, // ..............SV
	0x5f, 0x50, 0x4f, 0x53, 0x49, 0x54, 0x49, 0x4f, 0x4e, 0x00, 0x43, 0x4f, 0x4c, 0x4f, 0x52, 0x00, // _POSITION.COLOR.
	0xab, 0xab, 0x53, 0x48, 0x44, 0x52, 0xfc, 0x00, 0x00, 0x00, 0x40, 0x00, 0x01, 0x00, 0x3f, 0x00, // ..SHDR....@...?.
	0x00, 0x00, 0x59, 0x00, 0x00, 0x04, 0x46, 0x8e, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, // ..Y...F. .......
	0x00, 0x00, 0x5f, 0x00, 0x00, 0x03, 0xf2, 0x10, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5f, 0x00, // .._..........._.
	0x00, 0x03, 0x72, 0x10, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x67, 0x00, 0x00, 0x04, 0xf2, 0x20, // ..r.......g.... 
	0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x65, 0x00, 0x00, 0x03, 0xf2, 0x20, // ..........e.... 
	0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x68, 0x00, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x38, 0x00, // ......h.......8.
	0x00, 0x08, 0xf2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56, 0x15, 0x10, 0x00, 0x01, 0x00, // ..........V.....
	0x00, 0x00, 0x46, 0x8e, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x32, 0x00, // ..F. .........2.
	0x00, 0x0a, 0xf2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x8e, 0x20, 0x00, 0x00, 0x00, // ..........F. ...
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x10, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x46, 0x0e, // ..............F.
	0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x0a, 0xf2, 0x00, 0x10, 0x00, 0x00, 0x00, // ......2.........
	0x00, 0x00, 0x46, 0x8e, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0xa6, 0x1a, // ..F. ...........
	0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x46, 0x0e, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // ......F.........
	0x00, 0x08, 0xf2, 0x20, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x0e, 0x10, 0x00, 0x00, 0x00, // ... ......F.....
	0x00, 0x00, 0x46, 0x8e, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x36, 0x00, // ..F. .........6.
	0x00, 0x05, 0xf2, 0x20, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x46, 0x1e, 0x10, 0x00, 0x00, 0x00, // ... ......F.....
	0x00, 0x00, 0x3e, 0x00, 0x00, 0x01, 0x00, 0x02, 0x05, 0x00, 0x01, 0x00, 0x40, 0x00,             // ..>.........@.
};
static const uint8_t vs_debugdraw_lines_mtl[673] =
{
	0x56, 0x53, 0x48, 0x04, 0xa4, 0x8b, 0xef, 0x49, 0x01, 0x00, 0x0f, 0x75, 0x5f, 0x6d, 0x6f, 0x64, // VSH....I...u_mod
	0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x04, 0x01, 0x00, 0x00, 0x01, 0x00, // elViewProj......
	0x7c, 0x02, 0x00, 0x00, 0x75, 0x73, 0x69, 0x6e, 0x67, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x73, 0x70, // |...using namesp
	0x61, 0x63, 0x65, 0x20, 0x6d, 0x65, 0x74, 0x61, 0x6c, 0x3b, 0x0a, 0x73, 0x74, 0x72, 0x75, 0x63, // ace metal;.struc
	0x74, 0x20, 0x78, 0x6c, 0x61, 0x74, 0x4d, 0x74, 0x6c, 0x53, 0x68, 0x61, 0x64, 0x65, 0x72, 0x49, // t xlatMtlShaderI
	0x6e, 0x70, 0x75, 0x74, 0x20, 0x7b, 0x0a, 0x20, 0x20, 0x66, 0x6c, 0x6f, 0x61, 0x74, 0x34, 0x20, // nput {.  float4 
	0x61, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x30, 0x20, 0x5b, 0x5b, 0x61, 0x74, 0x74, 0x72, 0x69, // a_color0 [[attri
	0x62, 0x75, 0x74, 0x65, 0x28, 0x30, 0x29, 0x5d, 0x5d, 0x3b, 0x0a, 0x20, 0x20, 0x66, 0x6c, 0x6f, // bute(0)]];.  flo
	0x61, 0x74, 0x33, 0x20, 0x61, 0x5f, 0x70, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x5b, // at3 a_position [
	0x5b, 0x61, 0x74, 0x74, 0x72, 0x69, 0x62, 0x75, 0x74, 0x65, 0x28, 0x31, 0x29, 0x5d, 0x5d, 0x3b, // [attribute(1)]];
	0x0a, 0x7d, 0x3b, 0x0a, 0x73, 0x74, 0x72, 0x75, 0x63, 0x74, 0x20, 0x78, 0x6c, 0x61, 0x74, 0x4d, // .};.struct xlatM
	0x74, 0x6c, 0x53, 0x68, 0x61, 0x64, 0x65, 0x72, 0x4f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x20, 0x7b, // tlShaderOutput {
	0x0a, 0x20, 0x20, 0x66, 0x6c, 0x6f, 0x61, 0x74, 0x34, 0x20, 0x67, 0x6c, 0x5f, 0x50, 0x6f, 0x73, // .  float4 gl_Pos
	0x69, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x5b, 0x5b, 0x70, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, // ition [[position
	0x5d, 0x5d, 0x3b, 0x0a, 0x20, 0x20, 0x66, 0x6c, 0x6f, 0x61, 0x74, 0x34, 0x20, 0x76, 0x5f, 0x63, // ]];.  float4 v_c
	0x6f, 0x6c, 0x6f, 0x72, 0x30, 0x3b, 0x0a, 0x7d, 0x3b, 0x0a, 0x73, 0x74, 0x72, 0x75, 0x63, 0x74, // olor0;.};.struct
	0x20, 0x78, 0x6c, 0x61, 0x74, 0x4d, 0x74, 0x6c, 0x53, 0x68, 0x61, 0x64, 0x65, 0x72, 0x55, 0x6e, //  xlatMtlShaderUn
	0x69, 0x66, 0x6f, 0x72, 0x6d, 0x20, 0x7b, 0x0a, 0x20, 0x20, 0x66, 0x6c, 0x6f, 0x61, 0x74, 0x34, // iform {.  float4
	0x78, 0x34, 0x20, 0x75, 0x5f, 0x6d, 0x6f, 0x64, 0x65, 0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, // x4 u_modelViewPr
	0x6f, 0x6a, 0x3b, 0x0a, 0x7d, 0x3b, 0x0a, 0x76, 0x65, 0x72, 0x74, 0x65, 0x78, 0x20, 0x78, 0x6c, // oj;.};.vertex xl
	0x61, 0x74, 0x4d, 0x74, 0x6c, 0x53, 0x68, 0x61, 0x64, 0x65, 0x72, 0x4f, 0x75, 0x74, 0x70, 0x75, // atMtlShaderOutpu
	0x74, 0x20, 0x78, 0x6c, 0x61, 0x74, 0x4d, 0x74, 0x6c, 0x4d, 0x61, 0x69, 0x6e, 0x20, 0x28, 0x78, // t xlatMtlMain (x
	0x6c, 0x61, 0x74, 0x4d, 0x74, 0x6c, 0x53, 0x68, 0x61, 0x64, 0x65, 0x72, 0x49, 0x6e, 0x70, 0x75, // latMtlShaderInpu
	0x74, 0x20, 0x5f, 0x6d, 0x74, 0x6c, 0x5f, 0x69, 0x20, 0x5b, 0x5b, 0x73, 0x74, 0x61, 0x67, 0x65, // t _mtl_i [[stage
	0x5f, 0x69, 0x6e, 0x5d, 0x5d, 0x2c, 0x20, 0x63, 0x6f, 0x6e, 0x73, 0x74, 0x61, 0x6e, 0x74, 0x20, // _in]], constant 
	0x78, 0x6c, 0x61, 0x74, 0x4d, 0x74, 0x6c, 0x53, 0x68, 0x61, 0x64, 0x65, 0x72, 0x55, 0x6e, 0x69, // xlatMtlShaderUni
	0x66, 0x6f, 0x72, 0x6d, 0x26, 0x20, 0x5f, 0x6d, 0x74, 0x6c, 0x5f, 0x75, 0x20, 0x5b, 0x5b, 0x62, // form& _mtl_u [[b
	0x75, 0x66, 0x66, 0x65, 0x72, 0x28, 0x30, 0x29, 0x5d, 0x5d, 0x29, 0x0a, 0x7b, 0x0a, 0x20, 0x20, // uffer(0)]]).{.  
	0x78, 0x6c, 0x61, 0x74, 0x4d, 0x74, 0x6c, 0x53, 0x68, 0x61, 0x64, 0x65, 0x72, 0x4f, 0x75, 0x74, // xlatMtlShaderOut
	0x70, 0x75, 0x74, 0x20, 0x5f, 0x6d, 0x74, 0x6c, 0x5f, 0x6f, 0x3b, 0x0a, 0x20, 0x20, 0x66, 0x6c, // put _mtl_o;.  fl
	0x6f, 0x61, 0x74, 0x34, 0x20, 0x74, 0x6d, 0x70, 0x76, 0x61, 0x72, 0x5f, 0x31, 0x20, 0x3d, 0x20, // oat4 tmpvar_1 = 
	0x30, 0x3b, 0x0a, 0x20, 0x20, 0x74, 0x6d, 0x70, 0x76, 0x61, 0x72, 0x5f, 0x31, 0x2e, 0x77, 0x20, // 0;.  tmpvar_1.w 
	0x3d, 0x20, 0x31, 0x2e, 0x30, 0x3b, 0x0a, 0x20, 0x20, 0x74, 0x6d, 0x70, 0x76, 0x61, 0x72, 0x5f, // = 1.0;.  tmpvar_
	0x31, 0x2e, 0x78, 0x79, 0x7a, 0x20, 0x3d, 0x20, 0x5f, 0x6d, 0x74, 0x6c, 0x5f, 0x69, 0x2e, 0x61, // 1.xyz = _mtl_i.a
	0x5f, 0x70, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x3b, 0x0a, 0x20, 0x20, 0x5f, 0x6d, 0x74, // _position;.  _mt
	0x6c, 0x5f, 0x6f, 0x2e, 0x67, 0x6c, 0x5f, 0x50, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x20, // l_o.gl_Position 
	0x3d, 0x20, 0x28, 0x5f, 0x6d, 0x74, 0x6c, 0x5f, 0x75, 0x2e, 0x75, 0x5f, 0x6d, 0x6f, 0x64, 0x65, // = (_mtl_u.u_mode
	0x6c, 0x56, 0x69, 0x65, 0x77, 0x50, 0x72, 0x6f, 0x6a, 0x20, 0x2a, 0x20, 0x74, 0x6d, 0x70, 0x76, // lViewProj * tmpv
	0x61, 0x72, 0x5f, 0x31, 0x29, 0x3b, 0x0a, 0x20, 0x20, 0x5f, 0x6d, 0x74, 0x6c, 0x5f, 0x6f, 0x2e, // ar_1);.  _mtl_o.
	0x76, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x30, 0x20, 0x3d, 0x20, 0x5f, 0x6d, 0x74, 0x6c, 0x5f, // v_color0 = _mtl_
	0x69, 0x2e, 0x61, 0x5f, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x30, 0x3b, 0x0a, 0x20, 0x20, 0x72, 0x65, // i.a_color0;.  re
	0x74, 0x75, 0x72, 0x6e, 0x20, 0x5f, 0x6d, 0x74, 0x6c, 0x5f, 0x6f, 0x3b, 0x0a, 0x7d, 0x0a, 0x0a, // turn _mtl_o;.}..
	0x00,                                                                                           // .
};
extern const uint8_t* vs_debugdraw_lines_pssl;
extern const uint32_t vs_debugdraw_lines_pssl_size;
