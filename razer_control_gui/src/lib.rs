//! This is duplicated stuff for now, until we have a proper project structure

use serde::{Serialize, Deserialize};

pub fn get_device_file_path() -> String {
    let home = std::env::var("HOME").unwrap_or_else(|_| "/tmp".to_string());
    format!("{}/.local/share/razercontrol/laptops.json", home)
}

pub const DEVICE_FILE: &str = "/usr/share/razercontrol/laptops.json"; // Fallback for backwards compatibility

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SupportedDevice {
    pub name: String,
    pub vid: String,
    pub pid: String,
    pub features: Vec<String>,
    pub fan: Vec<u16>,
}

impl SupportedDevice {

    pub fn has_feature(&self, feature: &str) -> bool {
        self.features.iter().any(|f| f == feature)
    }

    pub fn can_boost(&self) -> bool {
        self.has_feature("boost")
    }

    pub fn has_logo(&self) -> bool {
        self.has_feature("logo")
    }

}
