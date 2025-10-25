// Function to transform vehicle data from DB to frontend format
function transformVehicle(vehicle) {
    const imageMap = {
        'md01': 'vf301.webp',
        'md02': 'vf6s001.webp',
        'md03': 'vf6plus001.webp',
        'md04': 'vf7s001.webp',
        'md05': 'vf7plus001.webp',
        'md06': 'vf8eco01.webp',
        'md07': 'vf8plus01.webp',
        'md08': 'vf9-eco-09.webp',
        'md09': 'vf9-plus-10.webp',
        'ms01': 'vffeliz2025.jpg',
        'ms02': 'vfventos.jpg',
        'ms03': 'vftheons.jpg',
        'ms04': 'verox.webp',
        'ms05': 'ventoneo.webp'
    };

    return {
        id: vehicle._id,
        name: vehicle.model,
        image: `/frontend/assets/images/${imageMap[vehicle._id] || 'default.webp'}`,
        price: vehicle.rentalPricePerDay ? vehicle.rentalPricePerDay.toLocaleString('vi-VN') : 'N/A',
        badges: ['Miễn phí sạc'],
        specs: [
            { icon: '/frontend/assets/images/car_model.svg', text: vehicle.vehicleType },
            { icon: '/frontend/assets/images/range_per_charge.svg', text: vehicle.range },
            { icon: '/frontend/assets/images/no_of_seat.svg', text: `${vehicle.seats} chỗ` },
            { icon: '/frontend/assets/images/trunk_capacity.svg', text: vehicle.features.find(f => f.includes('Dung tích cốp')) || 'N/A' }
        ]
    };
}

// Fetch vehicles from API
async function fetchVehicles(type = 'all') {
    try {
        const response = await fetch('http://localhost:3000/api/vehicles');
        const vehicles = await response.json();
        console.log('Fetched vehicles:', vehicles); // Debug
        let filtered = vehicles;
        if (type === 'cars') {
            filtered = vehicles.filter(v => v.vehicleType !== 'Xe Máy Điện');
        } else if (type === 'motorbikes') {
            filtered = vehicles.filter(v => v.vehicleType === 'Xe Máy Điện');
        }
        return filtered.map(transformVehicle);
    } catch (error) {
        console.error('Error fetching vehicles:', error);
        return [];
    }
}

// Replace static cars array
let cars = [];

// Note: Loading is handled in individual HTML files

function generateRentalList(items) {
    const carList = document.querySelector('.car-list');
    carList.innerHTML = items.map(item => `
        <a class="car-item" href="../car-detail/car-detail.html?id=${item.id}">
            <div class="relative car-image">
                <div class="absolute top-1 left-1 z-2 w-full">
                    <div class="flex gap-1">
                        ${item.badges.map(badge => `<div class="px-2 py-1 text-xs font-bold rounded" style="background-color: rgb(232, 238, 252); height: 28px; line-height: 28px; border-radius: 4px; padding: 0px 8px; color: #00d287;">${badge}</div>`).join('')}
                    </div>
                </div>
                <img alt="car" loading="lazy" width="377" height="212" decoding="async" data-nimg="1" class="w-auto" src="${item.image}" style="color: transparent; width: 377px; height: 212px; object-fit: cover; display: block; margin: 0 auto;">
            </div>
            <div class="relative car-info" style="margin-top: 16px;">
                <div class="absolute left-2/4 -translate-x-2/4 -translate-y-2/4 border border-[#b4c3de] p-4 bg-white h-max w-max">
                    <div class="flex items-center text-center">
                        <div class="font-normal text-[#3c3c3c]">Chỉ từ</div>
                        <div class="font-black text-2xl mx-2 text-[#00D287]">${item.price}</div>
                        <div class="font-semibold text-md translate-y-1/4 text-[#374151]">VNĐ/Ngày</div>
                    </div>
                </div>
                <div class="flex flex-col border border-[#4b9c6b] px-4 gap-4 pt-11 pb-4 info-detail">
                    <div class="text-center font-extrabold text-2xl text-[#111827]">${item.name}</div>
                    <div class="grid grid-cols-2 gap-x-0 gap-y-3">
                        ${item.specs.map((spec, index) => `
                            <div class="flex gap-2 items-center">
                                <img alt="car" loading="lazy" width="${spec.icon.includes('car_model') || spec.icon.includes('motor_model') ? 22 : spec.icon.includes('range_per_charge') ? 19 : spec.icon.includes('no_of_seat') ? 18 : 19}" height="${spec.icon.includes('car_model') || spec.icon.includes('motor_model') ? 16 : spec.icon.includes('range_per_charge') ? 12 : spec.icon.includes('no_of_seat') ? 18 : 18}" decoding="async" data-nimg="1" src="${spec.icon}" style="color: transparent;">
                                <div class="text-sm font-medium text-[#374151]">${spec.text}</div>
                            </div>
                            ${index % 2 === 1 && index < item.specs.length - 1 ? '<hr class="col-span-2 h-px border-[#d9e1e2] m-0">' : ''}
                        `).join('')}
                    </div>
                </div>
            </div>
        </a>
    `).join('');
}