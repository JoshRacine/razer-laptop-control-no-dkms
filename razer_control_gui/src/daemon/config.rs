use serde::{Deserialize, Serialize};
use std::{fs, fs::File, io, env};
use std::io::prelude::*;

const SETTINGS_FILE: &str = "/.local/share/razercontrol/daemon.json";

#[derive(Serialize, Deserialize, Copy, Clone)]
pub struct PowerConfig {
    pub power_mode: u8,
    pub cpu_boost: u8,
    pub gpu_boost: u8,
    pub fan_rpm: i32,
    pub screensaver: bool, // turno of keyboard light if screen is blank
    pub idle: u32,
}

impl PowerConfig {
    pub fn new() -> PowerConfig {
        return PowerConfig{
            power_mode: 0,
            cpu_boost: 1,
            gpu_boost: 0,
            fan_rpm: 0,
            screensaver: false,
            idle: 0,
        }
    }
}

#[derive(Serialize, Deserialize)]
pub struct Configuration {
    pub power: [PowerConfig; 2],
}

impl Configuration {
    pub fn new() -> Configuration {
        return Configuration {
            power: [PowerConfig::new(), PowerConfig::new()],
        };
    }

    pub fn write_to_file(&mut self) -> io::Result<()> {
        let j: String = serde_json::to_string_pretty(&self)?;
        File::create(get_home_directory() + SETTINGS_FILE)?.write_all(j.as_bytes())?;
        Ok(())
    }

    pub fn read_from_config() -> io::Result<Configuration> {
        let str = fs::read_to_string(get_home_directory() + SETTINGS_FILE)?;
        let res: Configuration = serde_json::from_str(str.as_str())?;
        Ok(res)
    }

}

fn get_home_directory() -> String {
    env::var("HOME").expect("The \"HOME\" environment variable must be set to a valid directory")
}
