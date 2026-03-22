document.addEventListener('DOMContentLoaded', () => {
    // --- User Form Modal Elements ---
    const userModal = document.getElementById('userModal');
    const userModalCloseButton = userModal.querySelector('.close-button');
    const addNewUserBtn = document.getElementById('addNewUserBtn');
    const userForm = document.getElementById('userForm');
    const usersTableBody = document.getElementById('usersTableBody');
    const userSearchInput = document.getElementById('userSearch');

    const modalTitle = document.getElementById('modalTitle');
    const userIdInput = document.getElementById('userId');
    const usernameInput = document.getElementById('username');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');
    const retypePasswordInput = document.getElementById('retype_password');
    const passwordHelp = document.getElementById('passwordHelp');
    
    // --- Manager Permissions Modal Elements ---
    const managerPermissionsModal = document.getElementById('managerPermissionsModal');
    const managerPermissionsForm = document.getElementById('managerPermissionsForm');
    const managerPermissionsTitle = document.getElementById('managerPermissionsTitle');
    const managerUserIdInput = document.getElementById('managerUserId');
    const managerPermissionsModalCloseButton = managerPermissionsModal.querySelector('.close-button');
    const cancelPermissionsBtn = document.getElementById('cancelPermissionsBtn');
    
    // --- MODIFIED: Get hidden action input and submit button ---
    const permissionActionInput = document.getElementById('permissionAction');
    const permissionSubmitBtn = document.getElementById('permissionSubmitBtn');


    // --- Alert/Confirm Modal Elements ---
    const alertModal = document.getElementById('alertModal');
    const modalHeaderIcon = document.getElementById('modalHeaderIcon'); // Get icon element
    const alertModalTitle = document.getElementById('alertModalTitle');
    const alertModalMessage = document.getElementById('alertModalMessage');
    const alertModalActions = document.getElementById('alertModalActions');
    const alertModalCloseBtn = alertModal.querySelector('.close-button');

    const showAlert = (title, message, callback = null) => {
        alertModalTitle.textContent = title;
        alertModalMessage.textContent = message;
        
        // Add icon
        if (title.toLowerCase().includes('error') || title.toLowerCase().includes('failed')) {
            modalHeaderIcon.innerHTML = '<i class="material-icons" style="color: #dc3545; font-size: 3.5em;">error</i>';
        } else if (title.toLowerCase().includes('success')) {
            modalHeaderIcon.innerHTML = '<i class="material-icons" style="color: #28a745; font-size: 3.5em;">check_circle</i>';
        } else {
             modalHeaderIcon.innerHTML = ''; // No icon
        }
        
        alertModalActions.innerHTML = '<button class="btn" id="alertOkBtn" style="background-color: #007bff; color: white;">OK</button>';
        alertModal.style.display = 'flex';

        document.getElementById('alertOkBtn').onclick = () => {
            alertModal.style.display = 'none';
            if (callback) callback();
        };
    };

    const showConfirm = (title, message, callback) => {
        alertModalTitle.textContent = title;
        alertModalMessage.textContent = message;
        modalHeaderIcon.innerHTML = ''; // No icon for simple confirm
        alertModalActions.innerHTML = `
            <button class="btn" id="confirmCancelBtn" style="background-color: #6c757d; color: white;">Cancel</button>
            <button class="btn" id="confirmOkBtn" style="background-color: #dc3545; color: white;">Yes, Proceed</button>
        `;
        alertModal.style.display = 'flex';

        document.getElementById('confirmOkBtn').onclick = () => {
            alertModal.style.display = 'none';
            callback(true);
        };
        document.getElementById('confirmCancelBtn').onclick = () => {
            alertModal.style.display = 'none';
            callback(false);
        };
    };

    // --- Close Modal Logic ---
    if(alertModalCloseBtn) alertModalCloseBtn.onclick = () => alertModal.style.display = 'none';
    window.addEventListener('click', (event) => {
        if (event.target === alertModal) {
            alertModal.style.display = 'none';
        }
    });

    const openModalForEdit = (user) => {
        userForm.reset();
        modalTitle.textContent = 'Edit Customer';
        userIdInput.value = user.id;
        usernameInput.value = user.username;
        emailInput.value = user.email;
        passwordInput.placeholder = "New password (optional)";
        passwordHelp.style.display = 'block';
        passwordInput.required = false;
        retypePasswordInput.required = false;
        userModal.style.display = 'flex';
    };

    const openModalForAdd = () => {
        userForm.reset();
        modalTitle.textContent = 'Add New Customer';
        userIdInput.value = '';
        passwordInput.placeholder = "Create a password";
        passwordHelp.style.display = 'none';
        passwordInput.required = true;
        retypePasswordInput.required = true;
        userModal.style.display = 'flex';
    };
    
    const closeUserModal = () => {
        userModal.style.display = 'none';
    };
    
    if(addNewUserBtn) addNewUserBtn.addEventListener('click', openModalForAdd);
    if(userModalCloseButton) userModalCloseButton.addEventListener('click', closeUserModal);
    window.addEventListener('click', (event) => {
        if (event.target === userModal) {
            closeUserModal();
        }
    });
    
    const closeManagerPermissionsModal = () => {
        managerPermissionsModal.style.display = 'none';
        managerPermissionsForm.reset();
    };

    if(managerPermissionsModalCloseButton) managerPermissionsModalCloseButton.addEventListener('click', closeManagerPermissionsModal);
    if(cancelPermissionsBtn) cancelPermissionsBtn.addEventListener('click', closeManagerPermissionsModal);
    window.addEventListener('click', (event) => {
        if (event.target === managerPermissionsModal) {
            closeManagerPermissionsModal();
        }
    });

    // --- CRUD and Verification Operations ---
    if(usersTableBody) {
        usersTableBody.addEventListener('click', (event) => {
            const target = event.target;
            const row = target.closest('tr');
            if (!row || !row.dataset.userId) return;

            const userId = row.dataset.userId;
            const username = row.dataset.username;

            if (target.classList.contains('view-edit-btn')) {
                const userData = { id: userId, username: username, email: row.dataset.email };
                openModalForEdit(userData);
            }

            if (target.classList.contains('delete-btn')) {
                showConfirm('Confirm Deletion', `Are you sure you want to delete this user (${username})? This action will move them to the archive.`, (confirmed) => {
                    if (confirmed) {
                        deleteUser(userId);
                    }
                });
            }
            
            if (target.classList.contains('verify-btn')) {
                showConfirm('Confirm Verification', `Are you sure you want to manually verify this user (${username})?`, (confirmed) => {
                    if (confirmed) {
                        verifyUser(userId, target);
                    }
                });
            }

            // --- THIS IS THE LOGIC FOR THE MANAGER BUTTONS ---
            if (target.classList.contains('promote-user-btn')) {
                managerPermissionsTitle.textContent = `Set Manager Permissions for ${username}`;
                managerUserIdInput.value = userId;
                managerPermissionsForm.reset(); // Clear old permissions
                permissionActionInput.value = 'promote'; // Set action
                permissionSubmitBtn.textContent = 'Save & Promote';
                managerPermissionsModal.style.display = 'flex';
            }

            if (target.classList.contains('edit-permissions-btn')) {
                const permissions = JSON.parse(row.dataset.permissions || '[]');
                
                managerPermissionsTitle.textContent = `Edit Manager Permissions for ${username}`;
                managerUserIdInput.value = userId;
                managerPermissionsForm.reset(); // Clear old checks first

                // Pre-check the boxes
                permissions.forEach(perm => {
                    const checkbox = document.getElementById(`perm_${perm}`);
                    if (checkbox) {
                        checkbox.checked = true;
                    }
                });
                
                permissionActionInput.value = 'edit_perms'; // Set action
                permissionSubmitBtn.textContent = 'Save Changes';
                managerPermissionsModal.style.display = 'flex';
            }

            if (target.classList.contains('demote-user-btn')) {
                showConfirm('Confirm Demotion', `Are you sure you want to demote this manager (${username}) to a user?`, (confirmed) => {
                    if (confirmed) {
                        demoteUser(userId); // Call the demote function
                    }
                });
            }
            // --- END OF MANAGER BUTTON LOGIC ---
        });
    }

    if(managerPermissionsForm) {
        managerPermissionsForm.addEventListener('submit', async (event) => {
            event.preventDefault();
            
            permissionSubmitBtn.classList.add('btn-loading'); // Add loading
            
            const formData = new FormData(managerPermissionsForm);
            
            try {
                const response = await fetch('/manage_user_role', { method: 'POST', body: formData }); // <-- FIXED
                const result = await response.json();
                
                showAlert(result.success ? 'Success!' : 'Error', result.message, () => {
                    if (result.success) {
                        closeManagerPermissionsModal();
                        location.reload();
                    }
                });
            } catch (error) {
                console.error('Error submitting form:', error);
                showAlert('Error', 'An unexpected network error occurred.');
            } finally {
                permissionSubmitBtn.classList.remove('btn-loading'); // Remove loading
            }
        });
    }

    if(userForm) {
        userForm.addEventListener('submit', async (event) => {
            event.preventDefault();
            
            const submitBtn = userModal.querySelector('button[form="userForm"]');
            submitBtn.classList.add('btn-loading');
                
            const password = passwordInput.value;
            const retypePassword = retypePasswordInput.value;

            if (password !== retypePassword) {
                showAlert('Error', 'The new passwords do not match.');
                submitBtn.classList.remove('btn-loading'); // Remove loading on validation error
                return;
            }

            const formData = new FormData(userForm);
            formData.append('action', 'saveUser');

            try {
                const response = await fetch('/manage_user', { method: 'POST', body: formData }); // <-- FIXED
                const result = await response.json();
                
                showAlert(result.success ? 'Success!' : 'Error', result.message, () => {
                    if (result.success) {
                        closeUserModal();
                        location.reload();
                    }
                });
            } catch (error) {
                console.error('Error submitting form:', error);
                showAlert('Error', 'An unexpected network error occurred.');
            } finally {
                submitBtn.classList.remove('btn-loading');
            }
        });
    }

    async function deleteUser(id) {
        const formData = new FormData();
        formData.append('action', 'deleteUser');
        formData.append('user_id', id);

        try {
            const response = await fetch('/manage_user', { method: 'POST', body: formData }); // <-- FIXED
            const result = await response.json();
            showAlert(result.success ? 'Success!' : 'Error', result.message, () => {
                if (result.success) location.reload();
            });
        } catch (error) {
            console.error('Error deleting user:', error);
            showAlert('Error', 'An unexpected network error occurred.');
        }
    }
    
    async function verifyUser(id, buttonElement) {
        const formData = new FormData();
        formData.append('user_id', id);

        try {
            const response = await fetch('/verify_user', { method: 'POST', body: formData }); // <-- FIXED
            const result = await response.json();
            
            showAlert(result.success ? 'Success!' : 'Error', result.message, () => {
                if (result.success) {
                    const statusCell = buttonElement.closest('tr').querySelector('.status-badge');
                    statusCell.classList.remove('pending');
                    statusCell.classList.add('confirmed');
                    statusCell.textContent = 'Verified';
                    buttonElement.remove();
                }
            });
        } catch (error) {
            console.error('Error verifying user:', error);
            showAlert('Error', 'An unexpected network error occurred.');
        }
    }

    async function demoteUser(id) {
        const formData = new FormData();
        formData.append('user_id', id);
        formData.append('action', 'demote'); // Send the 'demote' action

        try {
            const response = await fetch('/manage_user_role', { method: 'POST', body: formData }); // <-- FIXED
            const result = await response.json();
            
            showAlert(result.success ? 'Success!' : 'Error', result.message, () => {
                if (result.success) {
                    location.reload();
                }
            });
        } catch (error) {
            console.error('Error demoting user:', error);
            showAlert('Error', 'An unexpected network error occurred.');
        }
    }

    // --- Search Functionality ---
    if(userSearchInput) {
        userSearchInput.addEventListener('keyup', () => {
            const filter = userSearchInput.value.toLowerCase();
            const rows = usersTableBody.querySelectorAll('tr');

            rows.forEach(row => {
                const username = row.cells[1].textContent.toLowerCase();
                const email = row.cells[2].textContent.toLowerCase();
                if (username.includes(filter) || email.includes(filter)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }
});