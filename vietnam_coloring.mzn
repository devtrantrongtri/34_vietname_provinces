% Bài toán tô màu bản đồ 34 tỉnh thành Việt Nam
% Trả về kết quả JSON để tích hợp với Python

% Số lượng màu tối đa
int: num_colors = 4;

% Danh sách 34 tỉnh thành (theo thứ tự ID trong JSON)
enum PROVINCE = {
    TuyenQuang,    % ID: 1
    LaoCai,        % ID: 2  
    HaNoi,         % ID: 3
    QuangNinh,     % ID: 4
    ThaiNguyen,    % ID: 5
    LangSon,       % ID: 6
    CaoBang,       % ID: 7
    BacNinh,       % ID: 8
    HungYen,       % ID: 9
    NinhBinh,      % ID: 10
    ThanhHoa,      % ID: 11
    NgheAn,        % ID: 12
    HaTinh,        % ID: 13
    QuangTri,      % ID: 14
    Hue,           % ID: 15
    QuangNgai,     % ID: 16
    BinhDinh,      % ID: 17
    PhuYen,        % ID: 18
    KhanhHoa,      % ID: 19
    NinhThuan,     % ID: 20
    BinhThuan,     % ID: 21
    LamDong,       % ID: 22
    DakLak,        % ID: 23
    GiaLai,        % ID: 24
    KonTum,        % ID: 25
    DongNai,       % ID: 26
    BinhDuong,     % ID: 27
    TayNinh,       % ID: 28
    HoChiMinh,     % ID: 29
    AnGiang,       % ID: 30
    DongThap,      % ID: 31
    VinhLong,      % ID: 32
    CaMau,         % ID: 33
    BaRiaVungTau   % ID: 34
};

% Mảng ánh xạ từ PROVINCE sang ID
array[PROVINCE] of int: province_id = [
    1,  % TuyenQuang
    2,  % LaoCai
    3,  % HaNoi
    4,  % QuangNinh
    5,  % ThaiNguyen
    6,  % LangSon
    7,  % CaoBang
    8,  % BacNinh
    9,  % HungYen
    10, % NinhBinh
    11, % ThanhHoa
    12, % NgheAn
    13, % HaTinh
    14, % QuangTri
    15, % Hue
    16, % QuangNgai
    17, % BinhDinh
    18, % PhuYen
    19, % KhanhHoa
    20, % NinhThuan
    21, % BinhThuan
    22, % LamDong
    23, % DakLak
    24, % GiaLai
    25, % KonTum
    26, % DongNai
    27, % BinhDuong
    28, % TayNinh
    29, % HoChiMinh
    30, % AnGiang
    31, % DongThap
    32, % VinhLong
    33, % CaMau
    34  % BaRiaVungTau
];

% Biến quyết định: màu của mỗi tỉnh
array[PROVINCE] of var 1..num_colors: color;

% Ràng buộc giáp ranh (dựa trên thông tin địa lý thực tế)
% Miền Bắc
constraint color[TuyenQuang] != color[LaoCai];
constraint color[TuyenQuang] != color[CaoBang];
constraint color[TuyenQuang] != color[ThaiNguyen];

constraint color[LaoCai] != color[TuyenQuang];

constraint color[HaNoi] != color[ThaiNguyen];
constraint color[HaNoi] != color[BacNinh];
constraint color[HaNoi] != color[HungYen];

constraint color[QuangNinh] != color[LangSon];
constraint color[QuangNinh] != color[BacNinh];

constraint color[ThaiNguyen] != color[TuyenQuang];
constraint color[ThaiNguyen] != color[HaNoi];
constraint color[ThaiNguyen] != color[BacNinh];
constraint color[ThaiNguyen] != color[LangSon];

constraint color[LangSon] != color[CaoBang];
constraint color[LangSon] != color[ThaiNguyen];
constraint color[LangSon] != color[QuangNinh];

constraint color[CaoBang] != color[TuyenQuang];
constraint color[CaoBang] != color[LangSon];

constraint color[BacNinh] != color[HaNoi];
constraint color[BacNinh] != color[ThaiNguyen];
constraint color[BacNinh] != color[QuangNinh];
constraint color[BacNinh] != color[HungYen];

constraint color[HungYen] != color[HaNoi];
constraint color[HungYen] != color[BacNinh];
constraint color[HungYen] != color[NinhBinh];

constraint color[NinhBinh] != color[HungYen];
constraint color[NinhBinh] != color[ThanhHoa];

% Miền Trung
constraint color[ThanhHoa] != color[NinhBinh];
constraint color[ThanhHoa] != color[NgheAn];

constraint color[NgheAn] != color[ThanhHoa];
constraint color[NgheAn] != color[HaTinh];

constraint color[HaTinh] != color[NgheAn];
constraint color[QuangTri] != color[Hue];

constraint color[Hue] != color[QuangTri];
constraint color[Hue] != color[QuangNgai];

constraint color[QuangNgai] != color[Hue];
constraint color[QuangNgai] != color[BinhDinh];

constraint color[BinhDinh] != color[QuangNgai];
constraint color[BinhDinh] != color[PhuYen];

constraint color[PhuYen] != color[BinhDinh];
constraint color[PhuYen] != color[KhanhHoa];

constraint color[KhanhHoa] != color[PhuYen];
constraint color[KhanhHoa] != color[NinhThuan];
constraint color[KhanhHoa] != color[DakLak];

constraint color[NinhThuan] != color[KhanhHoa];
constraint color[NinhThuan] != color[BinhThuan];

constraint color[BinhThuan] != color[NinhThuan];
constraint color[BinhThuan] != color[LamDong];

% Miền Nam
constraint color[LamDong] != color[BinhThuan];
constraint color[LamDong] != color[DakLak];
constraint color[LamDong] != color[BinhDuong];

constraint color[DakLak] != color[LamDong];
constraint color[DakLak] != color[KhanhHoa];
constraint color[DakLak] != color[GiaLai];

constraint color[GiaLai] != color[DakLak];
constraint color[GiaLai] != color[KonTum];

constraint color[KonTum] != color[GiaLai];

constraint color[DongNai] != color[BinhDuong];
constraint color[DongNai] != color[TayNinh];
constraint color[DongNai] != color[BaRiaVungTau];

constraint color[BinhDuong] != color[LamDong];
constraint color[BinhDuong] != color[DongNai];
constraint color[BinhDuong] != color[TayNinh];
constraint color[BinhDuong] != color[HoChiMinh];

constraint color[TayNinh] != color[DongNai];
constraint color[TayNinh] != color[BinhDuong];
constraint color[TayNinh] != color[HoChiMinh];

constraint color[HoChiMinh] != color[BinhDuong];
constraint color[HoChiMinh] != color[TayNinh];
constraint color[HoChiMinh] != color[DongThap];

constraint color[AnGiang] != color[DongThap];
constraint color[AnGiang] != color[CaMau];

constraint color[DongThap] != color[AnGiang];
constraint color[DongThap] != color[HoChiMinh];
constraint color[DongThap] != color[VinhLong];

constraint color[VinhLong] != color[DongThap];
constraint color[VinhLong] != color[CaMau];

constraint color[CaMau] != color[AnGiang];
constraint color[CaMau] != color[VinhLong];

constraint color[BaRiaVungTau] != color[DongNai];

% Tối ưu hóa
var int: max_color_used = max(color);
solve minimize max_color_used;

% Output dạng JSON để Python dễ đọc
output [
    "{\n",
    "  \"total_colors\": " ++ show(max_color_used) ++ ",\n",
    "  \"coloring_result\": {\n"
] ++
[
    "    \"" ++ show(province_id[p]) ++ "\": " ++ show(color[p]) ++ 
    if p == BaRiaVungTau then "\n" else ",\n" endif
    | p in PROVINCE
] ++
[
    "  },\n",
    "  \"color_mapping\": {\n",
    "    \"1\": \"#FF6B6B\",\n",
    "    \"2\": \"#4ECDC4\",\n",
    "    \"3\": \"#45B7D1\",\n",
    "    \"4\": \"#96CEB4\"\n",
    "  }\n",
    "}\n"
];