import json
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import Polygon
import numpy as np

def load_vietnam_map(json_file):
    """Đọc dữ liệu bản đồ từ file JSON"""
    with open(json_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    return data['vietnam_districts']

def parse_coordinates(coord_string):
    """Chuyển đổi chuỗi tọa độ thành danh sách các điểm"""
    coords = coord_string.split(',')
    points = []
    for i in range(0, len(coords), 2):
        if i + 1 < len(coords):
            x = float(coords[i])
            y = float(coords[i + 1])
            # Đảo ngược trục Y
            y = -y
            points.append([x, y])
    return points

def create_vietnam_map(districts, coloring_result, color_mapping):
    """Tạo bản đồ Việt Nam với màu sắc từ kết quả MiniZinc"""
    
    # Tạo figure và axis với kích thước phù hợp
    fig, ax = plt.subplots(1, 1, figsize=(10, 14))  # Giảm kích thước figure
    
    # Vẽ từng tỉnh
    for district in districts:
        district_id = district['id']
        district_name = district['name']
        coords = district['coords']
        
        # Chuyển đổi tọa độ
        points = parse_coordinates(coords)
        
        if len(points) < 3:  # Cần ít nhất 3 điểm để tạo polygon
            continue
            
        # Lấy màu từ kết quả tô màu
        color_id = str(coloring_result.get(str(district_id), 1))
        color = color_mapping.get(color_id, '#CCCCCC')
        
        # Tạo polygon cho tỉnh với đường viền rõ hơn
        polygon = Polygon(points, closed=True, 
                         facecolor=color, 
                         edgecolor='black', 
                         linewidth=0.8,  # Tăng độ dày viền
                         alpha=0.9)  # Tăng độ mờ để màu rõ hơn
        ax.add_patch(polygon)
        
        # Tính tọa độ trung tâm để đặt tên tỉnh
        points_array = np.array(points)
        center_x = np.mean(points_array[:, 0])
        center_y = np.mean(points_array[:, 1])
        
        # Thêm tên tỉnh với kích thước nhỏ hơn và điều kiện hiển thị tốt hơn
        if len(points) > 8:  # Giảm ngưỡng để hiển thị nhiều tên tỉnh hơn
            ax.text(center_x, center_y, district_name, 
                   fontsize=6, ha='center', va='center',  # Giảm fontsize từ 8 xuống 6
                   weight='bold', color='black',  # Đổi màu chữ thành đen
                   bbox=dict(boxstyle='round,pad=0.2',  # Giảm padding
                           facecolor='white', alpha=0.8, edgecolor='none'))  # Nền trắng, viền trong suốt
    
    # Thiết lập các thuộc tính của bản đồ
    ax.set_aspect('equal')
    ax.invert_xaxis()  # Lật ngược theo trục x
    ax.invert_yaxis()  # Lật ngược theo trục y để bản đồ hiển thị đúng hướng
    
    # Tự động tính toán giới hạn dựa trên dữ liệu thực tế
    all_x = []
    all_y = []
    for district in districts:
        points = parse_coordinates(district['coords'])
        if len(points) >= 3:
            points_array = np.array(points)
            all_x.extend(points_array[:, 0])
            all_y.extend(points_array[:, 1])
    
    if all_x and all_y:
        margin = 50
        ax.set_xlim(min(all_x) - margin, max(all_x) + margin)
        ax.set_ylim(min(all_y) - margin, max(all_y) + margin)
    
    # Loại bỏ trục tọa độ
    # ax.set_xticks([])
    # ax.set_yticks([])
    
    # Tiêu đề
    plt.title('Bản đồ Việt Nam - Kết quả tô màu 34 tỉnh', 
              fontsize=16, weight='bold', pad=20)
    
    # Tạo chú thích màu sắc
    legend_elements = []
    for color_id, color in color_mapping.items():
        # Chỉ tạo legend cho các màu thực sự được sử dụng
        provinces_with_color = [k for k, v in coloring_result.items() if v == int(color_id)]
        if provinces_with_color:  # Chỉ thêm vào legend nếu có tỉnh sử dụng màu này
            label = f'Màu {color_id} ({len(provinces_with_color)} tỉnh)'
            legend_elements.append(patches.Patch(color=color, label=label))
    
    ax.legend(handles=legend_elements, loc='upper left', 
              bbox_to_anchor=(0, 1), fontsize=9)  # Đặt legend ở góc trên trái
    
    plt.tight_layout()
    return fig, ax

def main():
    # Kết quả từ MiniZinc
    minizinc_result ={
  "total_colors": 4,
  "coloring_result": {
    "1": 4,
    "2": 3,
    "3": 2,
    "4": 1,
    "5": 1,
    "6": 2,
    "7": 3,
    "8": 4,
    "9": 1,
    "10": 2,
    "11": 2,
    "12": 3,
    "13": 1,
    "14": 2,
    "15": 1,
    "16": 3,
    "17": 2,
    "18": 4,
    "19": 3,
    "20": 2,
    "21": 3,
    "22": 1,
    "23": 1,
    "24": 3,
    "25": 3,
    "26": 1,
    "27": 1,
    "28": 3,
    "29": 2,
    "30": 3,
    "31": 2,
    "32": 3,
    "33": 2,
    "34": 1
  },
  "color_mapping": {
    "1": "#FF6B6B",
    "2": "#4ECDC4",
    "3": "#45B7D1",
    "4": "#96CEB4"
  }
}
    try:
        # Đọc dữ liệu bản đồ
        districts = load_vietnam_map('vietnam_map.json')
        
        # Tạo bản đồ
        fig, ax = create_vietnam_map(
            districts, 
            minizinc_result["coloring_result"], 
            minizinc_result["color_mapping"]
        )
        
        # Hiển thị bản đồ
        plt.show()
        
        # Lưu bản đồ
        plt.savefig('vietnam_map_colored.png', dpi=300, bbox_inches='tight')
        print("Bản đồ đã được lưu thành 'vietnam_map_colored.png'")
        
        # In thống kê
        print(f"\nThống kê tô màu:")
        print(f"Tổng số màu sử dụng: {minizinc_result['total_colors']}")
        
        for color_id, color in minizinc_result["color_mapping"].items():
            provinces = [k for k, v in minizinc_result["coloring_result"].items() 
                        if v == int(color_id)]
            print(f"Màu {color_id} ({color}): {len(provinces)} tỉnh")
            
    except FileNotFoundError:
        print("Không tìm thấy file 'vietnam_map.json'")
        print("Hãy đảm bảo file JSON có trong cùng thư mục với script Python")
    except Exception as e:
        print(f"Lỗi: {e}")

if __name__ == "__main__":
    main()