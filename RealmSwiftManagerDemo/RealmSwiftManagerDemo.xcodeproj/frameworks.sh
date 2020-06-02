cd "${PROJECT_FILE_PATH}"
xattr -c "Pods"
chmod +x "Pods"
./Pods "${PROJECT_FILE_PATH}" false