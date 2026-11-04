# Lab 4 - Xử Lý Tín Hiệu Số (CO2036)

Mã nguồn Scilab cho Lab 4: biến đổi Z và các bài tập Scilab bổ sung.

## Cấu trúc

```
Lab_4_XLTHS/
├── Lab 4_Ex4/
│   └── Ex4.sce          # Thư viện xử lý âm thanh: wavread/wavwrite, lọc FIR thông thấp, analyze, mapsound
├── Lab 4_Ex5/
│   └── lab4_ex5.sci     # Xử lý ảnh (IPCV): histogram, cân bằng histogram, làm mờ 5x5, watermark
├── Lab 4_Ex6/
│   ├── Ex6.2.sci        # Tích chập tuyến tính - phương pháp folding and shifting
│   ├── Ex6.3.sci        # Tích chập tuyến tính - phương pháp ma trận
│   └── Ex6.4.sci        # Vẽ x(n), y(n) và năng lượng tín hiệu
├── Lab 4_Ex7/
│   └── Ex7.sce          # Tích chập vòng: folding and shifting, ma trận, năng lượng
└── README.md
```

Exercise 1-3 (biến đổi Z và ROC) là bài giải tay, được trình bày trong báo cáo.

## Chạy

- Scilab 2026.1.0.
- `lab4_ex5.sci` cần toolbox IPCV: `atomsInstall("IPCV")`, rồi đặt ảnh `input_image.png` cùng thư mục (nếu không có, chương trình tự tạo ảnh ngẫu nhiên).
