// Storage module for managing water check-in records
const Storage = {
    STORAGE_KEY: 'water_records',

    // Get all records from localStorage
    getAllRecords: function() {
        try {
            const data = localStorage.getItem(this.STORAGE_KEY);
            return data ? JSON.parse(data) : [];
        } catch (error) {
            console.error('Error reading records:', error);
            return [];
        }
    },

    // Save a new record
    saveRecord: function(record) {
        try {
            const records = this.getAllRecords();
            records.push(record);
            localStorage.setItem(this.STORAGE_KEY, JSON.stringify(records));
            return true;
        } catch (error) {
            console.error('Error saving record:', error);
            return false;
        }
    },

    // Get today's records
    getTodayRecords: function() {
        const records = this.getAllRecords();
        const today = new Date().toDateString();
        return records.filter(record => {
            const recordDate = new Date(record.id).toDateString();
            return recordDate === today;
        });
    },

    // Get today's count
    getTodayCount: function() {
        return this.getTodayRecords().length;
    },

    // Clear all records
    clearAllRecords: function() {
        try {
            localStorage.removeItem(this.STORAGE_KEY);
            return true;
        } catch (error) {
            console.error('Error clearing records:', error);
            return false;
        }
    }
};
