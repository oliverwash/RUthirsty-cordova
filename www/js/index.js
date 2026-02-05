// Main application logic
const App = {
    // Initialize the app
    init: function() {
        this.bindEvents();
        this.updateUI();
    },

    // Bind event listeners
    bindEvents: function() {
        const checkinBtn = document.getElementById('checkinBtn');
        const clearBtn = document.getElementById('clearBtn');

        checkinBtn.addEventListener('click', () => this.handleCheckin());
        clearBtn.addEventListener('click', () => this.handleClear());
    },

    // Handle check-in button click
    handleCheckin: function() {
        const now = new Date();
        const record = {
            id: now.getTime(),
            time: this.formatTime(now)
        };

        if (Storage.saveRecord(record)) {
            this.updateUI();
            this.showFeedback();
        }
    },

    // Handle clear button click
    handleClear: function() {
        if (confirm('确定要清空所有记录吗？')) {
            if (Storage.clearAllRecords()) {
                this.updateUI();
            }
        }
    },

    // Format time to readable string
    formatTime: function(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');
        return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    },

    // Update UI with current data
    updateUI: function() {
        this.updateTodayCount();
        this.renderRecordsList();
    },

    // Update today's count display
    updateTodayCount: function() {
        const count = Storage.getTodayCount();
        const countElement = document.getElementById('todayCount');
        countElement.textContent = count;
    },

    // Render records list
    renderRecordsList: function() {
        const recordsList = document.getElementById('recordsList');
        const records = Storage.getAllRecords();

        if (records.length === 0) {
            recordsList.innerHTML = '<div class="empty-state">暂无记录，点击上方按钮开始打卡吧！</div>';
            return;
        }

        // Sort records by time (newest first)
        records.sort((a, b) => b.id - a.id);

        // Render records
        recordsList.innerHTML = records.map(record => `
            <div class="record-item">
                <span class="record-time">${record.time}</span>
                <span class="record-icon">💧</span>
            </div>
        `).join('');
    },

    // Show visual feedback after check-in
    showFeedback: function() {
        const btn = document.getElementById('checkinBtn');
        btn.style.transform = 'scale(1.1)';
        setTimeout(() => {
            btn.style.transform = '';
        }, 200);
    }
};

// Wait for Cordova to be ready
document.addEventListener('deviceready', onDeviceReady, false);

function onDeviceReady() {
    console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);
    App.init();
}

// For browser testing (when Cordova is not available)
if (typeof cordova === 'undefined') {
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Running in browser mode');
        App.init();
    });
}
