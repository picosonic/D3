var dizzytable=[0x0002, 0x0082, 0x00fc, 0x016a, 0x01c0, 0x022e, 0x02a8, 0x0316, 0x036c, 0x03d4, 0x0454, 0x04d4, 0x054e, 0x05ce, 0x064e, 0x06ce, 0x0748, 0x07c8, 0x0848, 0x08c8, 0x0948, 0x09c8, 0x0a48, 0x0ac8, 0x0b42, 0x0bc2, 0x0c30, 0x0c8c, 0x0d06, 0x0d86, 0x0e00, 0x0e5c, 0x0ed6, 0x0f50, 0x0fac, 0x1026, 0x10a6, 0x1120];

var dizzydefs=[0xfc,0x11,0x15,0x03,0xff,0x00,0x83,0x00,0xff,0x00,0xff,0x00,0x01,0x7c,0xff,0x00,0xfe,0x00,0x00,0xfe,0xff,0x00,0xfc,0x01,0x00,0xff,0x7f,0x00,0xfc,0x01,0x00,0x93,0x7f,0x00,0xf8,0x03,0x00,0x11,0x3f,0x80,0xf8,0x03,0x00,0x55,0x3f,0x80,0xf8,0x03,0x00,0x11,0x3f,0x80,0xc0,0x07,0x00,0xff,0x07,0xc0,0x00,0x37,0x00,0xff,0x01,0xd8,0x00,0xf7,0x00,0x7d,0x00,0xde,0x00,0xf7,0x00,0x83,0x00,0xde,0x00,0xf3,0x00,0xef,0x00,0x9e,0x08,0x03,0x00,0xff,0x21,0x80,0xfc,0x00,0x00,0xfe,0x7f,0x00,0xff,0x00,0x01,0x00,0xff,0x00,0xfe,0x00,0x38,0x00,0xff,0x00,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xfc,0x01,0x10,0x45,0x7f,0x00,0xf8,0x02,0x00,0xeb,0x3f,0x80,0xf8,0x03,0x00,0xef,0x3f,0x80,0x14,0x04,0xff,0x00,0x83,0x00,0xff,0x00,0xff,0x00,0x01,0x7c,0xff,0x00,0xfe,0x00,0x00,0xfe,0xff,0x00,0xfc,0x01,0x00,0xff,0x7f,0x00,0xfc,0x01,0x00,0x93,0x7f,0x00,0x98,0x03,0x00,0x11,0x33,0x80,0x08,0x63,0x00,0x55,0x21,0x8c,0x00,0xf3,0x00,0x11,0x00,0x9e,0x00,0xf7,0x00,0xff,0x00,0xde,0x00,0x77,0x00,0xff,0x01,0xdc,0x80,0x07,0x00,0x7d,0x03,0xc0,0xf0,0x07,0x00,0x83,0x1f,0xc0,0xf8,0x03,0x00,0xef,0x3f,0x80,0xf8,0x03,0x00,0xff,0x3f,0x80,0xfc,0x00,0x00,0xfe,0x7f,0x00,0xfe,0x00,0x00,0x00,0xff,0x00,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xfc,0x01,0x10,0x45,0x7f,0x00,0xf8,0x02,0x00,0xeb,0x3f,0x80,0xf8,0x03,0x00,0xef,0x3f,0x80,0x12,0x06,0xff,0x00,0x83,0x00,0xff,0x00,0xfe,0x00,0x00,0x7c,0xff,0x00,0xfc,0x01,0x00,0xff,0x7f,0x00,0xf8,0x03,0x00,0xff,0x3f,0x80,0xf8,0x03,0x00,0xff,0x3f,0x80,0xf0,0x07,0x00,0xff,0x1f,0xc0,0xd0,0x07,0x00,0xff,0x17,0xc0,0x80,0x27,0x00,0x93,0x03,0xc8,0x00,0x77,0x00,0x11,0x01,0xdc,0x00,0xf7,0x00,0x55,0x00,0xde,0x08,0xe3,0x00,0xff,0x20,0x8e,0x0c,0x60,0x00,0xfe,0x61,0x0c,0x9e,0x00,0x00,0x00,0xf3,0x00,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xfc,0x01,0x10,0x45,0x7f,0x00,0xf8,0x02,0x00,0xeb,0x3f,0x80,0xf8,0x03,0x00,0xef,0x3f,0x80,0xfc,0x01,0x10,0xc7,0x7f,0x00,0x0e,0x05,0xff,0x00,0x39,0x00,0xff,0x00,0xfe,0x00,0x00,0xc6,0xff,0x00,0xfc,0x01,0x00,0x39,0x7f,0x00,0xfc,0x00,0x00,0xfe,0x7f,0x00,0xf8,0x03,0x00,0xff,0x3f,0x80,0xd8,0x03,0x00,0xff,0x37,0x80,0x80,0x27,0x00,0xff,0x03,0xc8,0x00,0x77,0x00,0xff,0x01,0xdc,0x00,0xf7,0x00,0xff,0x00,0xde,0x08,0xe3,0x00,0xff,0x20,0x8e,0x08,0x63,0x00,0xff,0x21,0x8c,0x9c,0x01,0x00,0x93,0x73,0x00,0xfe,0x00,0x00,0x7c,0xff,0x00,0xff,0x00,0x83,0x00,0xff,0x00,0x12,0x03,0xfe,0x00,0x38,0x00,0xff,0x00,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xf8,0x03,0x00,0xef,0x3f,0x80,0xf8,0x03,0x00,0xef,0x3f,0x80,0xfc,0x01,0x00,0xc7,0x7f,0x00,0xfc,0x01,0x00,0x01,0x7f,0x00,0xfc,0x00,0x00,0xfe,0x7f,0x00,0xf8,0x03,0x00,0xff,0x3f,0x80,0xc0,0x07,0x00,0xff,0x07,0xc0,0x00,0x37,0x00,0xff,0x01,0xd8,0x00,0xf7,0x00,0xff,0x00,0xde,0x00,0xe7,0x00,0xff,0x00,0xce,0x00,0xe7,0x00,0xff,0x00,0xce,0x18,0xc3,0x00,0xff,0x30,0x86,0x18,0x03,0x00,0xff,0x39,0x80,0xfc,0x01,0x00,0xff,0x7f,0x00,0xfe,0x00,0x00,0x7c,0xff,0x00,0xff,0x00,0x83,0x00,0xff,0x00,0x14,0x03,0xfc,0x00,0x10,0x00,0x7f,0x00,0xf8,0x03,0x00,0xef,0x3f,0x80,0xf8,0x03,0x00,0xef,0x3f,0x80,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xfe,0x00,0x00,0x00,0xff,0x00,0xfc,0x00,0x00,0xfe,0x7f,0x00,0xf8,0x03,0x00,0xff,0x3f,0x80,0xf8,0x03,0x00,0xff,0x3f,0x80,0x10,0x07,0x00,0xff,0x11,0xc0,0x00,0xe7,0x00,0xff,0x00,0xce,0x00,0xf7,0x00,0xff,0x00,0xde,0x00,0xf7,0x00,0xff,0x00,0xde,0x00,0xf3,0x00,0xff,0x00,0x9e,0x08,0xc3,0x00,0xff,0x20,0x86,0x3c,0x01,0x00,0xff,0x79,0x00,0xfc,0x01,0x00,0xff,0x7f,0x00,0xfe,0x00,0x00,0xfe,0xff,0x00,0xff,0x00,0x01,0x38,0xff,0x00,0xff,0x00,0xc7,0x00,0xff,0x00,0x12,0x03,0xfe,0x00,0x38,0x00,0xff,0x00,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xf8,0x03,0x00,0xef,0x3f,0x80,0xf8,0x03,0x00,0xef,0x3f,0x80,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xfc,0x01,0x00,0xc7,0x7f,0x00,0xfc,0x00,0x00,0x38,0x7f,0x00,0xf8,0x03,0x00,0xff,0x3f,0x80,0xf0,0x07,0x00,0xff,0x1f,0xc0,0x30,0x07,0x00,0xff,0x19,0xc0,0x00,0xc7,0x00,0xff,0x00,0xc6,0x00,0xf7,0x00,0xff,0x00,0xde,0x00,0xf7,0x00,0xff,0x00,0xde,0x00,0x73,0x00,0xff,0x01,0x9c,0x88,0x03,0x00,0xff,0x23,0x80,0xfc,0x01,0x00,0xff,0x7f,0x00,0xfe,0x00,0x00,0x7c,0xff,0x00,0xff,0x00,0x83,0x00,0xff,0x00,0x0e,0x06,0xfe,0x00,0x38,0x00,0xff,0x00,0xfc,0x01,0x10,0xc7,0x7f,0x00,0xf8,0x03,0x00,0xef,0x3f,0x80,0xf8,0x03,0x00,0xef,0x3f,0x80,0xfc,0x01,0x00,0xd7,0x7f,0x00,0x38,0x01,0x00,0xd7,0x39,0x00,0x10,0xc6,0x00,0xd6,0x10,0xc6,0x00,0xe7,0x00,0x39,0x00,0xce,0x00,0xf7,0x00,0xff,0x00,0xde,0x00,0x73,0x00,0xff,0x01,0x9c,0x88,0x03,0x00,0xff,0x23,0x80,0xfc,0x01,0x00,0xff,0x7f,0x00,0xfe,0x00,0x00,0x7c,0xff,0x00,0xff,0x00,0x83,0x00,0xff,0x00,0x11,0x07,0xff,0x00,0x83,0x00,0xff,0x00,0xfe,0x00,0x00,0x7c,0xff,0x00,0xfc,0x01,0x00,0x93,0x7f,0x00,0xf8,0x03,0x00,0x11,0x3f,0x80,0x38,0x03,0x00,0x55,0x39,0x80,0x10,0xc7,0x00,0xff,0x10,0xc6,0x00,0xe7,0x00,0x7d,0x00,0xce,0x00,0xf7,0x00,0x83,0x00,0xde,0x00,0x77,0x00,0xef,0x01,0xdc,0x80,0x07,0x00,0xff,0x03,0xc0,0xf8,0x02,0x00,0x38,0x3f,0x80,0xfc,0x01,0x00,0xd7,0x7f,0x00,0xf8,0x03,0x00,0xef,0x3f,0x80,0xf8,0x03,0x00,0xef,0x3f,0x80,0xfc,0x01,0x00,0xef,0x7f,0x00,0xfe,0x00,0x10,0xc6,0xff,0x00,0xff,0x00,0x39,0x00,0xff,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xf0,0x06,0x00,0xbf,0x7f,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xe0,0x0f,0x00,0x9f,0x3f,0x80,0xe0,0x0f,0x00,0x6f,0x3f,0x80,0xe0,0x0e,0x00,0xf7,0x3f,0x80,0xf0,0x00,0x00,0xf7,0x3f,0x80,0xf0,0x06,0x00,0xf7,0x7f,0x00,0xf0,0x07,0x00,0x6f,0x7f,0x00,0xf8,0x01,0x00,0x9c,0xff,0x00,0xfe,0x00,0x03,0x00,0xff,0x00,0xff,0x00,0x83,0x00,0xff,0x00,0xff,0x00,0x01,0x6c,0xff,0x00,0xfc,0x00,0x01,0x9c,0xff,0x00,0xf8,0x03,0x01,0x7c,0xff,0x00,0xf8,0x03,0x01,0x7c,0xff,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xf0,0x06,0x00,0xbf,0x7f,0x00,0xf0,0x06,0x00,0x3f,0x3f,0x80,0xe0,0x0f,0x00,0xf0,0x3f,0x80,0xe0,0x0f,0x00,0xef,0x7f,0x00,0xe0,0x0f,0x00,0x6f,0x3f,0x80,0xf0,0x00,0x00,0xf7,0x3f,0x80,0xf0,0x07,0x00,0xfb,0x3f,0x80,0xf0,0x07,0x00,0xfc,0x7f,0x00,0xf8,0x01,0x01,0xfc,0xff,0x00,0xfe,0x00,0x00,0x00,0xff,0x00,0xfe,0x00,0x10,0xc7,0x7f,0x00,0xf8,0x01,0x00,0xe7,0x3f,0x80,0xf0,0x07,0x00,0xdf,0x3f,0x80,0xf0,0x07,0x00,0xdf,0x7f,0x00,0xf8,0x01,0x00,0xdc,0xff,0x00,0x14,0x04,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xc0,0x06,0x00,0xbf,0x5f,0x00,0x80,0x2e,0x00,0x3f,0x0f,0xa0,0x00,0x6f,0x00,0xff,0x07,0x70,0x00,0xef,0x00,0xff,0x03,0x78,0x00,0xef,0x00,0x7f,0x03,0x78,0x00,0xe0,0x00,0xff,0x03,0xb8,0x10,0x07,0x00,0xff,0x47,0x00,0xf0,0x07,0x00,0xff,0x3f,0x00,0xe8,0x01,0x00,0xfc,0x1f,0xc0,0xc0,0x16,0x00,0x01,0x0f,0xe0,0x80,0x3f,0x7c,0x01,0x07,0xf0,0x80,0x3f,0x78,0x03,0x0f,0xe0,0xc0,0x1e,0xf8,0x03,0x1f,0xc0,0xe1,0x0c,0xfc,0x01,0x3f,0x80,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xfc,0x03,0x00,0xfe,0xff,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xf0,0x06,0x00,0xbf,0x7f,0x00,0xf0,0x06,0x00,0x3f,0x3f,0x80,0xe0,0x0f,0x00,0xf0,0x3f,0x80,0xe0,0x0f,0x00,0xef,0x7f,0x00,0xe0,0x0f,0x00,0x6f,0x3f,0x80,0xf0,0x00,0x00,0xf7,0x3f,0x80,0xf0,0x07,0x00,0xfb,0x3f,0x80,0xf0,0x07,0x00,0xfc,0x7f,0x00,0xf8,0x01,0x01,0xfc,0xff,0x00,0xfe,0x00,0x00,0x00,0xff,0x00,0xf2,0x00,0x10,0xc7,0x7f,0x00,0xe0,0x0d,0x00,0xe7,0x3f,0x80,0xe0,0x0f,0x00,0xdf,0x3f,0x80,0xf0,0x07,0x00,0xdf,0x7f,0x00,0xf8,0x01,0x00,0xdc,0xff,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xf0,0x06,0x00,0xbf,0x7f,0x00,0xf0,0x06,0x00,0x3f,0x3f,0x80,0xe0,0x0f,0x00,0x9f,0x3f,0x80,0xe0,0x0f,0x00,0x6f,0x3f,0x80,0xe0,0x0e,0x00,0xf7,0x3f,0x80,0xf0,0x00,0x00,0xf7,0x3f,0x80,0xf0,0x06,0x00,0xf7,0x7f,0x00,0xf0,0x07,0x00,0x6f,0x7f,0x00,0xf8,0x01,0x00,0x9c,0xff,0x00,0xfe,0x00,0x03,0x00,0xff,0x00,0xff,0x00,0x93,0x00,0xff,0x00,0xfe,0x00,0x01,0x6c,0xff,0x00,0xfc,0x01,0x01,0x9c,0xff,0x00,0xf8,0x03,0x01,0x7c,0xff,0x00,0xf8,0x03,0x01,0x7c,0xff,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xf0,0x06,0x00,0xbf,0x7f,0x00,0xf0,0x06,0x00,0x3f,0x3f,0x80,0xe0,0x0c,0x00,0x7f,0x3f,0x80,0xe0,0x0b,0x00,0xbf,0x3f,0x80,0xe0,0x07,0x00,0xdf,0x3f,0x80,0xe0,0x07,0x00,0xbf,0x3f,0x80,0xe0,0x0b,0x00,0x7f,0x7f,0x00,0xf0,0x04,0x00,0xfe,0xff,0x00,0xf8,0x01,0x01,0xfc,0xff,0x00,0xfc,0x00,0x00,0x00,0xff,0x00,0xe2,0x00,0x10,0xc7,0x7f,0x00,0xe0,0x0d,0x00,0xe7,0x3f,0x80,0xe0,0x0f,0x00,0xdf,0x3f,0x80,0xf0,0x07,0x00,0xdf,0x7f,0x00,0xf8,0x01,0x00,0xdc,0xff,0x00,0x14,0x04,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xd0,0x06,0x00,0xbf,0x5f,0x00,0x80,0x26,0x00,0x3f,0x0f,0xa0,0x00,0x77,0x00,0xff,0x07,0xb0,0x00,0xf7,0x00,0xff,0x03,0xb8,0x00,0xef,0x00,0x7f,0x03,0xb8,0x00,0xe0,0x00,0xff,0x03,0xb8,0x10,0x07,0x00,0xff,0x47,0x00,0xf0,0x07,0x00,0xff,0x3f,0x00,0xe8,0x01,0x00,0xfc,0x1f,0xc0,0xc0,0x16,0x00,0x01,0x0f,0xe0,0x80,0x3f,0x7c,0x01,0x07,0xf0,0x80,0x3f,0x78,0x03,0x0f,0xe0,0xc0,0x1e,0xf8,0x03,0x1f,0xc0,0xe1,0x0c,0xfc,0x01,0x3f,0x80,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xf0,0x06,0x00,0xbf,0x7f,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xe0,0x0c,0x00,0x7f,0x3f,0x80,0xe0,0x0b,0x00,0xbf,0x3f,0x80,0xe0,0x07,0x00,0xdf,0x3f,0x80,0xe0,0x07,0x00,0xbf,0x3f,0x80,0xe0,0x0b,0x00,0x7f,0x7f,0x00,0xf0,0x04,0x00,0xfe,0xff,0x00,0xf8,0x01,0x01,0xfc,0xff,0x00,0xfe,0x00,0x00,0x00,0xff,0x00,0xfe,0x00,0x10,0xc7,0x7f,0x00,0xf8,0x01,0x00,0xe7,0x3f,0x80,0xf0,0x07,0x00,0xdf,0x3f,0x80,0xf0,0x07,0x00,0xdf,0x7f,0x00,0xf8,0x01,0x00,0xdc,0xff,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xf0,0x07,0x00,0xeb,0x7f,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xe0,0x0f,0x00,0xcf,0x3f,0x80,0xe0,0x0f,0x00,0xb7,0x3f,0x80,0xe0,0x0f,0x00,0x7b,0x3f,0x80,0xf0,0x07,0x00,0x78,0x7f,0x00,0xf0,0x07,0x00,0x7b,0x7f,0x00,0xf0,0x07,0x00,0xb7,0x7f,0x00,0xf8,0x01,0x00,0xcc,0xff,0x00,0xfe,0x00,0x01,0x00,0xff,0x00,0xfe,0x00,0x4f,0x00,0xff,0x00,0xfc,0x01,0x03,0xb0,0xff,0x00,0xfc,0x01,0x01,0xcc,0xff,0x00,0xfc,0x01,0x00,0xf6,0xff,0x00,0xfc,0x01,0x00,0xf6,0xff,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xf0,0x07,0x00,0xeb,0x7f,0x00,0xf0,0x07,0x00,0xe3,0x3f,0x80,0xe0,0x0f,0x00,0xf1,0x3f,0x80,0xe0,0x0f,0x00,0xee,0x3f,0x80,0xe0,0x0f,0x00,0xdf,0x3f,0x00,0xf0,0x07,0x00,0xef,0x3f,0x00,0xf0,0x07,0x00,0xf6,0x3f,0x80,0xf0,0x07,0x00,0xf9,0x7f,0x00,0xf8,0x01,0x00,0xfc,0xff,0x00,0xf8,0x00,0x01,0x00,0xff,0x00,0xf0,0x07,0x44,0x10,0xff,0x00,0xe0,0x0f,0x00,0x3b,0x7f,0x00,0xe0,0x0f,0x00,0xdf,0x7f,0x00,0xf0,0x07,0x00,0xde,0xff,0x00,0xf8,0x01,0x01,0xdc,0xff,0x00,0x15,0x03,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xd0,0x07,0x00,0xeb,0x5f,0x00,0x80,0x2f,0x00,0xe3,0x0f,0xa0,0x00,0x6f,0x00,0xff,0x07,0x70,0x00,0xef,0x00,0xff,0x03,0x78,0x00,0xef,0x00,0xf7,0x03,0xb8,0x00,0xe7,0x00,0xf8,0x03,0x38,0x10,0x07,0x00,0xff,0x47,0x00,0xe0,0x07,0x00,0xff,0x7f,0x00,0xc0,0x19,0x00,0xfc,0xff,0x00,0x80,0x3c,0x00,0x03,0x3f,0x00,0x03,0x78,0xf0,0x07,0x1f,0xc0,0x81,0x3c,0xe0,0x0f,0x0f,0xe0,0xc0,0x1e,0xf0,0x07,0x1f,0xc0,0xe1,0x0c,0xf8,0x03,0x3f,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xf0,0x07,0x00,0xeb,0x7f,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xe0,0x0f,0x00,0xf1,0x3f,0x80,0xe0,0x0f,0x00,0xee,0x3f,0x80,0xe0,0x0f,0x00,0xdf,0x3f,0x00,0xf0,0x07,0x00,0xef,0x7f,0x00,0xf0,0x07,0x00,0xf6,0xff,0x00,0xf0,0x07,0x00,0xfa,0xff,0x00,0xf8,0x01,0x01,0xfc,0xff,0x00,0xf8,0x00,0x03,0x00,0xff,0x00,0xf0,0x07,0x45,0x10,0xff,0x00,0xe0,0x0f,0x00,0x3a,0xff,0x00,0xe0,0x0f,0x00,0xbf,0x7f,0x00,0xf0,0x07,0x00,0xde,0xff,0x00,0xf8,0x01,0x01,0xdc,0xff,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xf0,0x07,0x00,0xeb,0x7f,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xe0,0x0f,0x00,0xcf,0x3f,0x80,0xe0,0x0f,0x00,0xb7,0x3f,0x80,0xe0,0x0f,0x00,0x7b,0x3f,0x80,0xf0,0x07,0x00,0x78,0x7f,0x00,0xf0,0x07,0x00,0x7b,0x7f,0x00,0xf0,0x07,0x00,0xb7,0x7f,0x00,0xf8,0x01,0x00,0xcc,0xff,0x00,0xfe,0x00,0x03,0x00,0xff,0x00,0xfe,0x00,0x0f,0x00,0xff,0x00,0xfc,0x01,0x07,0xb0,0xff,0x00,0xfc,0x01,0x01,0xc8,0xff,0x00,0xfc,0x01,0x00,0xf6,0xff,0x00,0xfc,0x01,0x00,0xf6,0xff,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xf0,0x07,0x00,0xeb,0x7f,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xe0,0x0c,0x00,0x7f,0x3f,0x80,0xe0,0x0b,0x00,0xbf,0x3f,0x80,0xe0,0x07,0x00,0xd7,0x3f,0x80,0xf0,0x07,0x00,0xb8,0x7f,0x00,0xf0,0x07,0x00,0x7f,0x7f,0x00,0xf0,0x00,0x00,0xff,0x7f,0x00,0xf8,0x01,0x00,0xfc,0xff,0x00,0xf8,0x00,0x03,0x00,0xff,0x00,0xf0,0x07,0x45,0x10,0xff,0x00,0xe0,0x0f,0x00,0x3a,0xff,0x00,0xe0,0x0f,0x00,0xdf,0x7f,0x00,0xf0,0x07,0x00,0xde,0xff,0x00,0xf8,0x01,0x01,0xdc,0xff,0x00,0x14,0x04,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xd0,0x07,0x00,0xeb,0x5f,0x00,0x80,0x27,0x00,0xe3,0x0f,0x20,0x00,0x77,0x00,0xff,0x07,0xb0,0x00,0xf7,0x00,0xff,0x03,0xb8,0x00,0xf7,0x00,0xf7,0x03,0xb8,0x00,0xe7,0x00,0xf8,0x03,0x38,0x10,0x07,0x00,0xff,0x47,0x00,0xe0,0x07,0x00,0xff,0x7f,0x00,0xc0,0x19,0x00,0xfc,0x7f,0x00,0x80,0x3c,0x00,0x03,0x1f,0x40,0x01,0x7c,0xf0,0x07,0x0f,0xe0,0x80,0x3e,0xe0,0x0f,0x0f,0xe0,0xc0,0x1e,0xf0,0x07,0x1f,0xc0,0xe1,0x0c,0xf8,0x03,0x3f,0x00,0x15,0x03,0xff,0x00,0x07,0x00,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xf0,0x07,0x00,0xeb,0x7f,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xe0,0x0c,0x00,0x7f,0x3f,0x80,0xe0,0x0b,0x00,0xbf,0x3f,0x80,0xe0,0x07,0x00,0xd7,0x3f,0x80,0xf0,0x07,0x00,0xb8,0x7f,0x00,0xf0,0x03,0x00,0x7f,0x7f,0x00,0xf0,0x04,0x00,0xff,0x7f,0x00,0xf8,0x01,0x00,0xfc,0xff,0x00,0xf8,0x00,0x03,0x00,0xff,0x00,0xf0,0x07,0x44,0x10,0xff,0x00,0xe0,0x0f,0x00,0x3b,0x7f,0x00,0xe0,0x0f,0x00,0xbf,0x7f,0x00,0xf0,0x07,0x00,0xde,0xff,0x00,0xf8,0x01,0x01,0xdc,0xff,0x00,0x12,0x06,0xf0,0x00,0x7f,0x00,0xff,0x00,0xe0,0x0f,0x0f,0x80,0xff,0x00,0xc0,0x1f,0x03,0xf0,0xff,0x00,0x80,0x3f,0x01,0xfc,0xff,0x00,0x80,0x3f,0x00,0xfe,0xff,0x00,0x80,0x3f,0x00,0xfe,0xff,0x00,0x80,0x30,0x00,0xff,0x7f,0x00,0x80,0x32,0x00,0x8f,0x7f,0x00,0xc0,0x18,0x00,0x77,0x7f,0x00,0xc0,0x1f,0x00,0x7b,0x7f,0x00,0xe0,0x0e,0x00,0xfa,0xbf,0x00,0xe0,0x0e,0x01,0x34,0x1f,0x40,0xf0,0x04,0x02,0xc8,0x0f,0xe0,0xf8,0x01,0x04,0xe0,0x07,0xf0,0xfe,0x00,0x18,0x02,0x0f,0xe0,0xff,0x00,0xf8,0x03,0x1f,0xc0,0xff,0x00,0xf0,0x07,0x3f,0x00,0xff,0x00,0xf0,0x07,0x7f,0x00,0x0f,0x07,0xff,0x00,0x0f,0x00,0xff,0x00,0xf8,0x00,0x03,0xf0,0xff,0x00,0xe0,0x07,0x01,0xfc,0xff,0x00,0xc0,0x1f,0x01,0xfc,0x87,0x00,0x80,0x3f,0x00,0xfe,0x03,0x78,0x00,0x7f,0x00,0xc6,0x03,0x78,0x00,0x7f,0x00,0xba,0x83,0x38,0x00,0x7f,0x00,0x7c,0x03,0x58,0x00,0x78,0x00,0x7c,0x03,0x58,0x00,0x72,0x00,0xba,0x83,0x20,0x80,0x30,0x00,0xc6,0x83,0x38,0xc0,0x1f,0x01,0xec,0xc3,0x18,0xe0,0x07,0x01,0xec,0xe7,0x00,0xf8,0x00,0x03,0xe0,0xff,0x00,0xff,0x00,0x1f,0x00,0xff,0x00,0x14,0x04,0xff,0x00,0xfe,0x00,0xff,0x00,0xff,0x00,0xfc,0x01,0x7f,0x00,0xff,0x00,0xf8,0x03,0x3f,0x80,0xff,0x00,0xf0,0x07,0x1f,0xc0,0xff,0x00,0xf0,0x07,0x0f,0xc0,0xfe,0x00,0x08,0x01,0x07,0x10,0xf8,0x01,0x04,0xf0,0x03,0xf8,0xf0,0x07,0x02,0xc8,0x07,0x30,0xe0,0x0f,0x01,0xb4,0xcf,0x00,0xc0,0x1f,0x00,0x7a,0xff,0x00,0xc0,0x1f,0x00,0x7b,0x7f,0x00,0xc0,0x1f,0x00,0x7b,0x7f,0x00,0x80,0x3f,0x00,0xb1,0x7f,0x00,0x80,0x3f,0x00,0x0c,0xff,0x00,0x80,0x3e,0x00,0x7e,0xff,0x00,0x80,0x3e,0x01,0x3c,0xff,0x00,0xc0,0x1e,0x03,0x38,0xff,0x00,0xc0,0x1f,0x07,0x60,0xff,0x00,0xe0,0x0f,0x1f,0x80,0xff,0x00,0xf0,0x00,0x7f,0x00,0xff,0x00,0x15,0x03,0xfe,0x00,0x01,0x00,0xff,0x00,0xfc,0x01,0x00,0xf6,0xff,0x00,0xfc,0x01,0x00,0xf6,0xff,0x00,0xfc,0x01,0x01,0xc8,0xff,0x00,0xfc,0x01,0x07,0xb0,0xff,0x00,0xfe,0x00,0x03,0x00,0xff,0x00,0xf8,0x01,0x00,0xcc,0xff,0x00,0xf0,0x07,0x00,0xb7,0x7f,0x00,0xf0,0x07,0x00,0x7b,0x7f,0x00,0xe0,0x0f,0x00,0x78,0x7f,0x00,0xe0,0x0f,0x00,0x7b,0x3f,0x80,0xe0,0x0f,0x00,0xb7,0x3f,0x80,0xe0,0x0f,0x00,0xcf,0x3f,0x80,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xf0,0x07,0x00,0xeb,0x7f,0x00,0xf0,0x07,0x00,0xe3,0x7f,0x00,0xf8,0x03,0x00,0xf2,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xfe,0x00,0x07,0x00,0xff,0x00,0x14,0x04,0xf9,0x00,0xff,0x00,0xff,0x00,0xf0,0x06,0xff,0x00,0xff,0x00,0xe0,0x0f,0x7f,0x00,0xff,0x00,0xc0,0x06,0xff,0x00,0xff,0x00,0x80,0x3a,0x87,0x00,0xff,0x00,0x00,0x7a,0x01,0x78,0xff,0x00,0x00,0x70,0x00,0xd2,0xff,0x00,0x80,0x39,0x00,0x27,0x7f,0x00,0xc0,0x02,0x00,0xe7,0x7f,0x00,0xf8,0x02,0x00,0xfb,0x3f,0x80,0xf0,0x06,0x00,0xf7,0x1f,0xc0,0xf0,0x07,0x00,0x70,0x1f,0xc0,0xe0,0x0f,0x00,0x8a,0x0f,0x60,0xf0,0x07,0x00,0xf8,0x0f,0x60,0xf0,0x07,0x00,0xff,0x0f,0xe0,0xf8,0x03,0x00,0xff,0x1f,0xc0,0xfc,0x01,0x00,0xff,0x1f,0xc0,0xfe,0x00,0x00,0x7f,0x3f,0x80,0xff,0x00,0x80,0x0c,0x7f,0x00,0xff,0x00,0xf3,0x00,0xff,0x00,0x0f,0x05,0xff,0x00,0xc7,0x00,0xff,0x00,0xfe,0x00,0x00,0x38,0xff,0x00,0x3c,0x01,0x00,0xbf,0x3f,0x00,0x1c,0xc1,0x00,0xbf,0x1f,0xc0,0x08,0xe3,0x00,0x18,0x0f,0x60,0x08,0x22,0x00,0xaa,0x07,0x70,0x00,0xd1,0x00,0xf0,0x07,0xf0,0x00,0xd1,0x00,0xf7,0x07,0xf0,0x08,0xe2,0x00,0xef,0x07,0xf0,0x00,0xf3,0x00,0x1f,0x07,0xf0,0x00,0xf3,0x00,0xff,0x0f,0xe0,0x04,0x01,0x00,0xff,0x1f,0xc0,0xfc,0x01,0x00,0xff,0x3f,0x00,0xfe,0x00,0x00,0x78,0xff,0x00,0xff,0x00,0x87,0x00,0xff,0x00,0x14,0x04,0xff,0x00,0xc1,0x00,0xff,0x00,0xff,0x00,0x00,0x3e,0xff,0x00,0xfe,0x00,0x00,0xff,0x7f,0x00,0xfc,0x01,0x00,0xcf,0x3f,0x80,0xf8,0x03,0x00,0x8f,0x3f,0x80,0xf0,0x07,0x00,0xaf,0x1f,0xc0,0xf0,0x07,0x00,0x8f,0x1f,0xc0,0xf0,0x03,0x00,0x1f,0x1f,0xc0,0xe0,0x08,0x00,0xef,0x3f,0x80,0xe0,0x0d,0x00,0xef,0x3f,0x80,0xf0,0x05,0x00,0xef,0x3f,0x80,0xf0,0x06,0x00,0xef,0x7f,0x00,0xf8,0x03,0x00,0x1f,0x7f,0x00,0xfc,0x00,0x00,0xfe,0xff,0x00,0xe0,0x00,0x01,0x78,0xff,0x00,0xc0,0x1a,0x07,0x00,0xff,0x00,0x80,0x38,0x3f,0x80,0xff,0x00,0xc0,0x17,0x1f,0xc0,0xff,0x00,0xe0,0x07,0x3f,0x80,0xff,0x00,0xf8,0x03,0x3f,0x80,0xff,0x00,0x14,0x03,0xff,0x00,0xf0,0x00,0x7f,0x00,0xff,0x00,0x80,0x0f,0x3f,0x80,0xfe,0x00,0x00,0x7f,0x1f,0xc0,0xfc,0x01,0x00,0xff,0x0f,0xe0,0xf8,0x03,0x00,0xff,0x0f,0xe0,0xf8,0x03,0x00,0xff,0x0f,0xe0,0xf0,0x07,0x00,0xf8,0x0f,0x60,0xf0,0x07,0x00,0x8a,0x0f,0x60,0xf0,0x07,0x00,0x70,0x1f,0xc0,0xf0,0x06,0x00,0xf7,0x1f,0xc0,0xe0,0x02,0x00,0xf7,0x3f,0x80,0xc0,0x11,0x00,0x6b,0x3f,0x80,0x82,0x38,0x00,0x99,0x7f,0x00,0x00,0x70,0x00,0x3c,0xff,0x00,0x80,0x3a,0xc3,0x00,0xff,0x00,0xc0,0x1a,0xff,0x00,0xff,0x00,0xe0,0x06,0xff,0x00,0xff,0x00,0xf0,0x07,0x7f,0x00,0xff,0x00,0xf8,0x02,0xff,0x00,0xff,0x00,0xfd,0x00,0xff,0x00,0xff,0x00,0x0f,0x06,0xff,0x00,0x87,0x00,0xff,0x00,0xfe,0x00,0x00,0x78,0xff,0x00,0xfc,0x01,0x00,0xff,0x3f,0x00,0x0c,0x01,0x00,0xff,0x1f,0xc0,0x00,0xf3,0x00,0xff,0x0f,0xe0,0x00,0xf3,0x00,0x1f,0x07,0xf0,0x00,0xe2,0x00,0xef,0x07,0xf0,0x00,0xd1,0x00,0xf7,0x07,0xf0,0x00,0xd1,0x00,0xf0,0x07,0xf0,0x08,0x22,0x00,0xaa,0x07,0x70,0x18,0xc3,0x00,0x18,0x0f,0x60,0x1c,0xc1,0x00,0xbf,0x1f,0xc0,0x3c,0x01,0x00,0xbf,0x3f,0x00,0xfe,0x00,0x00,0x38,0xff,0x00,0xff,0x00,0xc7,0x00,0xff,0x00,0x14,0x02,0xfb,0x00,0xff,0x00,0xff,0x00,0xf1,0x04,0xff,0x00,0xff,0x00,0xe0,0x0e,0xff,0x00,0xff,0x00,0xc0,0x1f,0x7f,0x00,0xff,0x00,0x80,0x1f,0x7f,0x00,0xff,0x00,0x00,0x68,0x83,0x00,0xff,0x00,0x07,0xe0,0x00,0x7c,0xff,0x00,0x1e,0x40,0x00,0x9f,0x7f,0x00,0xbc,0x00,0x00,0x6f,0x3f,0x80,0xf8,0x01,0x00,0xf7,0x1f,0xc0,0xf0,0x06,0x00,0xf7,0x1f,0xc0,0xf0,0x06,0x00,0xf7,0x1f,0xc0,0xf0,0x04,0x00,0x6f,0x0f,0xe0,0xf8,0x01,0x00,0x87,0x0f,0xe0,0xf8,0x03,0x00,0xf3,0x0f,0xe0,0xfc,0x01,0x00,0xe3,0x0f,0xe0,0xfe,0x00,0x00,0xe3,0x1f,0xc0,0xff,0x00,0x00,0x3f,0x1f,0xc0,0xff,0x00,0xc0,0x0f,0x3f,0x80,0xff,0x00,0xf0,0x00,0x7f,0x00,0x15,0x01,0xfc,0x00,0x03,0x00,0xff,0x00,0xf8,0x03,0x01,0x7c,0xff,0x00,0xf8,0x03,0x01,0x7c,0xff,0x00,0xfc,0x01,0x01,0x9c,0xff,0x00,0xfe,0x00,0x01,0x6c,0xff,0x00,0xfe,0x00,0x03,0x00,0xff,0x00,0xf8,0x01,0x00,0x9c,0xff,0x00,0xf0,0x07,0x00,0x6f,0x7f,0x00,0xf0,0x06,0x00,0xf7,0x7f,0x00,0xf0,0x00,0x00,0x77,0x3f,0x80,0xe0,0x0e,0x00,0xf7,0x3f,0x80,0xe0,0x0f,0x00,0x6f,0x3f,0x80,0xe0,0x0f,0x00,0x9f,0x3f,0x80,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xf0,0x06,0x00,0xbf,0x7f,0x00,0xf0,0x06,0x00,0x3f,0x7f,0x00,0xf8,0x02,0x00,0x7e,0xff,0x00,0xf8,0x03,0x00,0xfe,0xff,0x00,0xfc,0x01,0x01,0xfc,0xff,0x00,0xfe,0x00,0x03,0xf8,0xff,0x00,0xff,0x00,0x07,0x00,0xff,0x00,0x14,0x03,0xff,0x00,0xfc,0x00,0xff,0x00,0xff,0x00,0xf8,0x03,0x7f,0x00,0xff,0x00,0xf0,0x07,0x3f,0x80,0xff,0x00,0xf8,0x03,0x1f,0x40,0xff,0x00,0x08,0x02,0x0f,0xe0,0xfc,0x00,0x00,0xf3,0x07,0x70,0xf8,0x02,0x00,0x78,0x07,0xf0,0xf0,0x07,0x00,0x4c,0x0f,0xe0,0xf0,0x07,0x00,0x36,0x1f,0x00,0xe0,0x0e,0x00,0xfa,0xff,0x00,0xc0,0x1f,0x00,0x7b,0x7f,0x00,0xc0,0x18,0x00,0x77,0x7f,0x00,0x80,0x32,0x00,0x8f,0x3f,0x80,0x80,0x31,0x00,0xff,0x7f,0x00,0x80,0x3f,0x00,0xff,0x7f,0x00,0xc0,0x1f,0x00,0xfe,0xff,0x00,0xc0,0x1f,0x01,0xfc,0xff,0x00,0xe0,0x0f,0x03,0xf0,0xff,0x00,0xf0,0x01,0x0f,0x80,0xff,0x00,0xfe,0x00,0x7f,0x00,0xff,0x00,0x0f,0x06,0xff,0x00,0x1f,0x00,0xff,0x00,0xf8,0x00,0x03,0xe0,0xff,0x00,0xe0,0x07,0x01,0xec,0xe7,0x00,0xc0,0x1f,0x01,0xec,0xc3,0x18,0x80,0x30,0x00,0xc6,0xc3,0x18,0x00,0x72,0x00,0xba,0x83,0x20,0x00,0x78,0x00,0x7c,0x03,0x58,0x00,0x7f,0x00,0x7c,0x03,0x58,0x00,0x7f,0x00,0xba,0x83,0x38,0x00,0x7f,0x00,0xc6,0x03,0x78,0x80,0x3f,0x00,0xfe,0x03,0x78,0xc0,0x1f,0x01,0xfc,0x87,0x00,0xe0,0x07,0x01,0xfc,0xff,0x00,0xf8,0x00,0x03,0xf0,0xff,0x00,0xff,0x00,0x0f,0x00,0xff,0x00,0x15,0x02,0xfc,0x00,0x1f,0x00,0xff,0x00,0xf8,0x03,0x07,0xe0,0xff,0x00,0xf0,0x07,0x03,0xf8,0xff,0x00,0xe0,0x0f,0x01,0x9c,0xff,0x00,0xe0,0x0f,0x00,0x8e,0xff,0x00,0xc0,0x1f,0x00,0xaf,0x7f,0x00,0xc0,0x1f,0x00,0x8f,0x7f,0x00,0xc0,0x1f,0x00,0xc6,0x7f,0x00,0xe0,0x0f,0x00,0xb8,0x3f,0x80,0xe0,0x0f,0x00,0xbd,0x3f,0x80,0xe0,0x0f,0x00,0xbd,0x7f,0x00,0xf0,0x07,0x00,0xb9,0x7f,0x00,0xf0,0x07,0x00,0xc6,0xff,0x00,0xf8,0x03,0x01,0xf8,0xff,0x00,0xfc,0x00,0x04,0xf0,0x1f,0x00,0xff,0x00,0x00,0x02,0x0f,0xe0,0xff,0x00,0xe0,0x09,0x0f,0x60,0xff,0x00,0xc0,0x1f,0x1f,0x80,0xff,0x00,0xe0,0x0f,0x3f,0x00,0xff,0x00,0xe0,0x0e,0xff,0x00,0xff,0x00,0xf1,0x00,0xff,0x00];