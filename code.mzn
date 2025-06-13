% Bài toán tô màu bản đồ 63 tỉnh thành Việt Nam
% Trả về kết quả JSON để tích hợp với Python

% Số lượng màu tối đa
int: num_colors = 4;

% Danh sách 34 tỉnh thành chính (theo yêu cầu của bạn)
enum PROVINCE = {
    TuyenQuang,   % 1
    LaoCai,       % 2
    ThaiNguyen,   % 3
    PhuTho,       % 4
    BacNinh,      % 5
    HungYen,      % 6
    HaiPhong,     % 7
    NinhBinh,     % 8
    Hue,          % 9
    QuangTri,     % 10
    DaNang,       % 11
    QuangNgai,    % 12
    GiaLai,       % 13
    KhanhHoa,     % 14
    LamDong,      % 15
    DakLak,       % 16
    HoChiMinh,    % 17
    DongNai,      % 18
    TayNinh,      % 19
    CanTho,       % 20
    VinhLong,     % 21
    DongThap,     % 22
    CaMau,        % 23
    AnGiang,      % 24
    DienBien,     % 25
    CaoBang,      % 26
    LaiChau,      % 27
    LangSon,      % 28
    SonLa,        % 29
    HaNoi,        % 30
    QuangNinh,    % 31
    ThanhHoa,     % 32
    NgheAn,       % 33
    HaTinh        % 34
};

% Mảng ánh xạ từ PROVINCE sang ID
array[PROVINCE] of int: province_id = [
    1,  % TuyenQuang
    2,  % LaoCai
    3,  % ThaiNguyen
    4,  % PhuTho
    5,  % BacNinh
    6,  % HungYen
    7,  % HaiPhong
    8,  % NinhBinh
    9,  % Hue
    10, % QuangTri
    11, % DaNang
    12, % QuangNgai
    13, % GiaLai
    14, % KhanhHoa
    15, % LamDong
    16, % DakLak
    17, % HoChiMinh
    18, % DongNai
    19, % TayNinh
    20, % CanTho
    21, % VinhLong
    22, % DongThap
    23, % CaMau
    24, % AnGiang
    25, % DienBien
    26, % CaoBang
    27, % LaiChau
    28, % LangSon
    29, % SonLa
    30, % HaNoi
    31, % QuangNinh
    32, % ThanhHoa
    33, % NgheAn
    34  % HaTinh
];

% Biến quyết định: màu của mỗi tỉnh
array[PROVINCE] of var 1..num_colors: color;

% Ràng buộc giáp ranh theo địa lý thực tế Việt Nam

% === MIỀN BẮC ===

% Tây Bắc
constraint color[LaiChau] != color[DienBien];
constraint color[LaiChau] != color[SonLa];
constraint color[LaiChau] != color[LaoCai];

constraint color[DienBien] != color[LaiChau];
constraint color[DienBien] != color[SonLa];

constraint color[SonLa] != color[LaiChau];
constraint color[SonLa] != color[DienBien];
constraint color[SonLa] != color[LaoCai];
constraint color[SonLa] != color[PhuTho];
constraint color[SonLa] != color[ThanhHoa];

% Vùng núi phía Bắc
constraint color[LaoCai] != color[LaiChau];
constraint color[LaoCai] != color[SonLa];
constraint color[LaoCai] != color[TuyenQuang];
constraint color[LaoCai] != color[PhuTho];

constraint color[TuyenQuang] != color[LaoCai];
constraint color[TuyenQuang] != color[CaoBang];
constraint color[TuyenQuang] != color[ThaiNguyen];
constraint color[TuyenQuang] != color[PhuTho];

constraint color[CaoBang] != color[TuyenQuang];
constraint color[CaoBang] != color[LangSon];
constraint color[CaoBang] != color[ThaiNguyen];

constraint color[LangSon] != color[CaoBang];
constraint color[LangSon] != color[ThaiNguyen];
constraint color[LangSon] != color[QuangNinh];
constraint color[LangSon] != color[BacNinh];

constraint color[ThaiNguyen] != color[TuyenQuang];
constraint color[ThaiNguyen] != color[CaoBang];
constraint color[ThaiNguyen] != color[LangSon];
constraint color[ThaiNguyen] != color[PhuTho];
constraint color[ThaiNguyen] != color[HaNoi];
constraint color[ThaiNguyen] != color[BacNinh];

constraint color[PhuTho] != color[LaoCai];
constraint color[PhuTho] != color[SonLa];
constraint color[PhuTho] != color[TuyenQuang];
constraint color[PhuTho] != color[ThaiNguyen];
constraint color[PhuTho] != color[HaNoi];
constraint color[PhuTho] != color[NinhBinh];
constraint color[PhuTho] != color[ThanhHoa];

% Đồng bằng Bắc Bộ
constraint color[HaNoi] != color[ThaiNguyen];
constraint color[HaNoi] != color[PhuTho];
constraint color[HaNoi] != color[BacNinh];
constraint color[HaNoi] != color[HungYen];
constraint color[HaNoi] != color[NinhBinh];

constraint color[BacNinh] != color[ThaiNguyen];
constraint color[BacNinh] != color[LangSon];
constraint color[BacNinh] != color[HaNoi];
constraint color[BacNinh] != color[QuangNinh];
constraint color[BacNinh] != color[HaiPhong];
constraint color[BacNinh] != color[HungYen];

constraint color[QuangNinh] != color[LangSon];
constraint color[QuangNinh] != color[BacNinh];
constraint color[QuangNinh] != color[HaiPhong];

constraint color[HaiPhong] != color[QuangNinh];
constraint color[HaiPhong] != color[BacNinh];
constraint color[HaiPhong] != color[HungYen];

constraint color[HungYen] != color[HaNoi];
constraint color[HungYen] != color[BacNinh];
constraint color[HungYen] != color[HaiPhong];
constraint color[HungYen] != color[NinhBinh];

constraint color[NinhBinh] != color[HaNoi];
constraint color[NinhBinh] != color[PhuTho];
constraint color[NinhBinh] != color[HungYen];
constraint color[NinhBinh] != color[ThanhHoa];

% === MIỀN TRUNG ===

% Bắc Trung Bộ
constraint color[ThanhHoa] != color[SonLa];
constraint color[ThanhHoa] != color[PhuTho];
constraint color[ThanhHoa] != color[NinhBinh];
constraint color[ThanhHoa] != color[NgheAn];

constraint color[NgheAn] != color[ThanhHoa];
constraint color[NgheAn] != color[HaTinh];

constraint color[HaTinh] != color[NgheAn];
constraint color[HaTinh] != color[QuangTri];

% Trung Trung Bộ
constraint color[QuangTri] != color[HaTinh];
constraint color[QuangTri] != color[Hue];

constraint color[Hue] != color[QuangTri];
constraint color[Hue] != color[DaNang];

constraint color[DaNang] != color[Hue];
constraint color[DaNang] != color[QuangNgai];

constraint color[QuangNgai] != color[DaNang];
constraint color[QuangNgai] != color[GiaLai];
constraint color[QuangNgai] != color[KhanhHoa];

% Tây Nguyên và Nam Trung Bộ
constraint color[GiaLai] != color[QuangNgai];
constraint color[GiaLai] != color[DakLak];
constraint color[GiaLai] != color[KhanhHoa];

constraint color[DakLak] != color[GiaLai];
constraint color[DakLak] != color[KhanhHoa];
constraint color[DakLak] != color[LamDong];

constraint color[KhanhHoa] != color[QuangNgai];
constraint color[KhanhHoa] != color[GiaLai];
constraint color[KhanhHoa] != color[DakLak];
constraint color[KhanhHoa] != color[LamDong];

constraint color[LamDong] != color[DakLak];
constraint color[LamDong] != color[KhanhHoa];
constraint color[LamDong] != color[DongNai];
constraint color[LamDong] != color[HoChiMinh];

% === MIỀN NAM ===

% Đông Nam Bộ
constraint color[DongNai] != color[LamDong];
constraint color[DongNai] != color[HoChiMinh];
constraint color[DongNai] != color[TayNinh];

constraint color[TayNinh] != color[DongNai];
constraint color[TayNinh] != color[HoChiMinh];
constraint color[TayNinh] != color[DongThap];

constraint color[HoChiMinh] != color[LamDong];
constraint color[HoChiMinh] != color[DongNai];
constraint color[HoChiMinh] != color[TayNinh];
constraint color[HoChiMinh] != color[DongThap];

% Đồng bằng sông Cửu Long
constraint color[DongThap] != color[TayNinh];
constraint color[DongThap] != color[HoChiMinh];
constraint color[DongThap] != color[AnGiang];
constraint color[DongThap] != color[VinhLong];
constraint color[DongThap] != color[CanTho];

constraint color[AnGiang] != color[DongThap];
constraint color[AnGiang] != color[CanTho];
constraint color[AnGiang] != color[CaMau];

constraint color[VinhLong] != color[DongThap];
constraint color[VinhLong] != color[CanTho];

constraint color[CanTho] != color[DongThap];
constraint color[CanTho] != color[AnGiang];
constraint color[CanTho] != color[VinhLong];
constraint color[CanTho] != color[CaMau];

constraint color[CaMau] != color[AnGiang];
constraint color[CaMau] != color[CanTho];

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
    if p == HaTinh then "\n" else ",\n" endif
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