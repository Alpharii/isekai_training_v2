shader_type canvas_item;
render_mode unshaded;

// Slot Warna di Inspector
uniform vec4 warna_atas : source_color = vec4(1.0, 1.0, 1.0, 1.0);     // Putih (Atas)
uniform vec4 warna_tengah : source_color = vec4(1.0, 0.84, 0.0, 1.0);   // Emas Cerah (Tengah / Bawah)
uniform vec4 warna_bawah : source_color = vec4(0.5, 0.35, 0.0, 1.0);    // Emas Gelap (Paling Bawah)

uniform bool pakai_warna_tiga = false; 
uniform vec2 ukuran_label = vec2(100.0, 50.0); 

varying float posisi_y_persen;

void vertex() {
	posisi_y_persen = VERTEX.y / ukuran_label.y;
}

void fragment() {
	// 1. Ambil warna pixel asli bawaan dari sistem Theme / Font Godot (termasuk warna teks asli & outline asli)
	vec4 warna_asli_godot = texture(TEXTURE, UV) * COLOR;
	
	float persen = clamp(posisi_y_persen, 0.0, 1.0);
	vec4 warna_gradasi;
	
	if (pakai_warna_tiga) {
		if (persen < 0.5) {
			warna_gradasi = mix(warna_atas, warna_tengah, persen * 2.0);
		} else {
			warna_gradasi = mix(warna_tengah, warna_bawah, (persen - 0.5) * 2.0);
		}
	} else {
		warna_gradasi = mix(warna_atas, warna_tengah, persen);
	}
	
	// 2. MODIFIKASI KRUSIAL: 
	// Kita periksa warna teks asli bawaan Godot. Jika warnanya putih atau mendekati putih (Teks Utama),
	// kita aplikasikan warna gradasi emas. Jika warnanya hitam/gelap (Outline), kita biarkan warna aslinya tetap hitam.
	// Trik ini memisahkan area teks utama dengan area outline secara sempurna.
	if (warna_asli_godot.r > 0.05 || warna_asli_godot.g > 0.05 || warna_asli_godot.b > 0.05) {
		COLOR.rgb = warna_gradasi.rgb;
	} else {
		COLOR.rgb = warna_asli_godot.rgb;
	}
	
	// Tetap pertahankan nilai transparansi huruf agar tidak kotak hitam
	COLOR.a = warna_asli_godot.a;
}
