require 'rails_helper'

RSpec.describe 'login function', type: :system do

  let!(:user) { User.create(name: 'user_name', email: 'user@email.com', password: 'password') }
  let!(:second_user) { User.create(name: 'second_user_name', email: 'second_user@email.com', password: 'password') }

  describe 'Screen transition requirements' do
    context 'If you are logged out' do
      it 'Path prefix can be used as per requirement' do
        visit new_session_path
        visit new_user_path
      end
    end
  end

  describe 'Screen design requirements' do
    context 'If you are logging out' do
      describe 'HTML id and class attributes must be given as per requirements' do
        it 'Global Navigation' do
          visit root_path
          expect(page).to have_css '#sign-up'
          expect(page).to have_css '#sign-in'
          expect(page).not_to have_css '#my-account'
          expect(page).not_to have_css '#sign-out'
          expect(page).not_to have_css '#tasks-index'
          expect(page).not_to have_css '#new-task'
        end
        it 'Login Screen' do
          visit new_session_path
          expect(page).to have_css '#create-session'
        end
      end
    end
  end

  describe 'Screen requirements' do
    context 'If you are logged out' do
      describe 'Display text, links and buttons on each screen as per requirements' do
        it 'Global navigation' do
          visit root_path
          expect(page).to have_link 'Register Account'
          expect(page).to have_link 'Login'
        end
        it 'Login screen' do
          visit new_session_path
          expect(page).to have_content 'Login Page'
          expect(page).to have_selector 'label', text: 'Email Address'
          expect(page).to have_selector 'label', text: 'Password'
          expect(page).to have_button 'Login'
        end
        it 'Account registration screen' do
          visit new_user_path
          expect(page).to have_content 'Account Registration Page'
          expect(page).to have_selector 'label', text: 'Name'
          expect(page).to have_selector 'label', text: 'Email Address'
          expect(page).to have_selector 'label', text: 'Password'
          expect(page).to have_selector 'label', text: 'Password (confirmation)'
          expect(page).to have_button 'Register'
        end
      end
    end
  end

  describe 'Screen transition requirements' do
    context 'In case of logout' do
      describe 'Transition as per screen transition diagram' do
        it 'Make global navigation links transition as per requirements' do
          visit root_path
          click_link 'Login'
          expect(page).to have_content 'Login Page'
          click_link 'Register Account'
          expect(page).to have_content 'Account Registration Page'
        end
        it 'If the account registration is successful, "Task List Page" will be displayed in the page title' do
          visit new_user_path
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set('new_user@email.com')
          find('input[name="user[password]"]').set('new_password')
          find('input[name="user[password_confirmation]"]').set('new_password')
          click_button 'Register'
          expect(page).to have_content 'Task List Page'
        end
        it 'If account registration fails, "Account Registration Page" will be displayed in the page title' do
          visit new_user_path
          find('input[name="user[name]"]').set('')
          find('input[name="user[email]"]').set('')
          find('input[name="user[password]"]').set('')
          find('input[name="user[password_confirmation]"]').set('')
          click_button 'Register'
          expect(page).to have_content 'Account Registration Page'
        end
        it 'If login is successful, "Task List Page" will be displayed in the page title' do
          visit new_session_path
          find('input[name="session[email]"]').set(user.email)
          find('input[name="session[password]"]').set(user.password)
          click_button 'Login'
          expect(page).to have_content 'Task List Page'
        end
        it 'If login fails, "Login page" will be displayed in the page title' do
          visit new_session_path
          find('input[name="session[email]"]').set('failed@email.com')
          find('input[name="session[password]"]').set('failed_password')
          click_button 'Login'
          expect(page).to have_content 'Login Page'
        end
      end
    end
  end

  describe 'Screen transition requirements' do
    context 'If you are logged in' do
      before do
        visit new_session_path
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button "Login"
      end
      it 'The path prefix can be used as per requirement' do
        visit user_path(user)
        visit edit_user_path(user)
      end
    end
  end

  describe 'Screen transition requirements' do
    context 'If you are logged in' do
      before do
        visit new_session_path
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button "Login"
      end
      it 'The path prefix can be used as per requirement' do
        visit user_path(user)
        visit edit_user_path(user)
      end
    end
  end

  describe 'Screen design requirements' do
    context 'If you are logged in' do
      before do
        visit new_session_path
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button "Login"
      end
      describe 'HTML id and class attributes are given as per requirement' do
        it 'Global navigation' do
          expect(page).to have_css '#my-account'
          expect(page).to have_css '#sign-out'
          expect(page).to have_css '#tasks-index'
          expect(page).to have_css '#new-task'
          expect(page).not_to have_css '#sign-up'
          expect(page).not_to have_css '#sign-in'
        end
        it 'account detail screen' do
          visit user_path(user)
          expect(page).to have_css '#edit-user'
          expect(page).to have_css '#destroy-user'
        end
        it 'account edit screen' do
          visit edit_user_path(user)
          expect(page).to have_css '#back'
        end
      end
    end
  end

  describe 'Screen requirements' do
    context 'If you are logged in' do
      before do
        visit new_session_path
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button 'Login'
      end
      describe 'Display text, links and buttons on each screen as per requirement' do
        it 'global navigation' do
          expect(page).to have_link 'Task list'
          expect(page).to have_link 'Register a task'
          expect(page).to have_link 'Account'
          expect(page).to have_link 'Logout'
        end
        it 'account detail screen' do
          visit user_path(user)
          expect(page).to have_content 'Account Detail Page'
          expect(page).to have_content 'Name'
          expect(page).to have_content 'Email Address'
          expect(page).to have_link 'edit'
          expect(page).to have_link 'delete'
        end
        it 'account edit screen' do
          visit edit_user_path(user)
          expect(page).to have_content 'Account Edit Page'
          expect(page).to have_selector 'label', text: 'Name'
          expect(page).to have_selector 'label', text: 'Email Address'
          expect(page).to have_selector 'label', text: 'Password'
          expect(page).to have_selector 'label', text: 'Password (confirmation)'
          expect(page).to have_button 'Update'
          expect(page).to have_link 'Back'
        end
      end
    end
  end

  describe 'Screen transition requirements' do
    context 'If you are logged in' do
      before do
        visit new_session_path
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button 'Login'
      end
      describe 'Making the transition as per the screen transition diagram' do
        it 'Make the global navigation links transition as per the requirements' do
          click_link 'Task list'
          expect(page).to have_content 'Task List Page'
          click_link 'Register a task'
          expect(page).to have_content 'Task Registration Page'
          click_link 'Account'
          expect(page).to have_content 'Account Detail Page'
          click_link 'Logout'
          expect(page).to have_content 'Login Page'
        end
        it 'When "edit" is clicked on the account detail page, "Account Edit Page" will be displayed in the page title' do
          visit user_path(user)
          click_link 'edit'
          expect(page).to have_content 'Edit Account Page'
        end
        it 'When "delete" is clicked on the account detail page, the "Login Page" will be displayed in the page title' do
          visit user_path(user)
          click_link 'delete'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'Login Page'
        end
        it 'If the account is successfully edited, "Account Detail Page" will be displayed in the page title' do
          visit edit_user_path(user)
          find('input[name="user[name]"]').set('edit_user_name')
          find('input[name="user[email]"]').set('edit_user@email.com')
          find('input[name="user[password]"]').set('edit_password')
          find('input[name="user[password_confirmation]"]').set('edit_password')
          click_button 'Update'
          expect(page).to have_content 'Account Detail Page'
        end
        it 'If editing the account fails, "Edit Account Page" will be displayed in the page title' do
          visit edit_user_path(user)
          find('input[name="user[name]"]').set('')
          find('input[name="user[email]"]').set('')
          find('input[name="user[password]"]').set('')
          find('input[name="user[password_confirmation]"]').set('')
          click_button 'Update'
          expect(page).to have_content 'Account Edit Page'
        end
        it 'If you click "Back" on the account edit page, the page title will show "Account Detail Page"' do
          visit edit_user_path(user)
          click_link 'Back'
          expect(page).to have_content 'Account Detail Page'
        end
      end
    end
  end

  describe 'Functional requirements' do
    describe 'When clicking on a link to delete a user, the confirmation dialog should say "Are you sure you want to delete the user? in the confirmation dialog when clicking on a link to delete a user.' do
      before do
        visit new_session_path
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button 'Login'
      end
      it 'When you click on the link to delete a user, the confirmation dialog should say "Are you sure you want to delete? in the confirmation dialog when clicking the link to delete the user.' do
        visit user_path(user)
        click_link 'delete'
        expect(page.driver.browser.switch_to.alert.text).to eq 'Are you sure you want to delete?'
      end
    end

    describe 'To display a validation message when account registration or editing fails, as per the conditions indicated in the requirement' do
      context 'Account registration screen' do
        it 'Validation message if all forms are unfilled' do
          visit new_user_path
          find('input[name="user[name]"]').set('')
          find('input[name="user[email]"]').set('')
          find('input[name="user[password]"]').set('')
          find('input[name="user[password_confirmation]"]').set('')
          click_button 'Register'
          expect(page).to have_content 'Please enter your name'
          expect(page).to have_content 'Please enter your email address'
          expect(page).to have_content 'Please enter your password'
        end
        it 'Validation message if you enter an email address that is already in use' do
          visit new_user_path
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set(user.email)
          find('input[name="user[password]"]').set('password')
          find('input[name="user[password_confirmation]"]').set('password')
          click_button 'Register'
          expect(page).to have_content 'Your email address is already in use'
        end
        it 'Validation message if password is less than 6 characters' do
          visit new_user_path
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set('new_user@email.com')
          find('input[name="user[password]"]').set('passw')
          find('input[name="user[password_confirmation]"]').set('passw')
          click_button 'Register'
          expect(page).to have_content 'Please enter a password of at least 6 characters'
        end
        it 'Validation message if password and password (confirmation) do not match' do
          visit new_user_path
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set('new_user@email.com')
          find('input[name="user[password]"]').set('password')
          find('input[name="user[password_confirmation]"]').set('passwordd')
          click_button 'Register'
          expect(page).to have_content 'Password (confirmation) and password input do not match'
        end
      end
      context 'Account edit screen' do
        before do
          visit new_session_path
          find('input[name="session[email]"]').set(user.email)
          find('input[name="session[password]"]').set(user.password)
          click_button 'Login'
        end
        it 'Validation message if all forms are unfilled' do
          visit edit_user_path(user)
          find('input[name="user[name]"]').set('')
          find('input[name="user[email]"]').set('')
          find('input[name="user[password]"]').set('')
          find('input[name="user[password_confirmation]"]').set('')
          click_button 'Update'
          expect(page).to have_content 'Please enter your name'
          expect(page).to have_content 'Please enter your email address'
          expect(page).to have_content 'Please enter your password'
        end
        it 'Validation message if you enter an email address that is already in use' do
          visit edit_user_path(user)
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set(second_user.email)
          find('input[name="user[password]"]').set('password')
          find('input[name="user[password_confirmation]"]').set('password')
          click_button 'Update'
          expect(page).to have_content 'The email address is already in use'
        end
        it 'Validation message if password is less than 6 characters' do
          visit edit_user_path(user)
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set('new_user@email.com')
          find('input[name="user[password]"]').set('passw')
          find('input[name="user[password_confirmation]"]').set('passw')
          click_button 'Update'
          expect(page).to have_content 'Please enter a password of at least 6 characters'
        end
        it 'Validation message if password and password (confirmation) do not match' do
          visit edit_user_path(user)
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set('new_user@email.com')
          find('input[name="user[password]"]').set('password')
          find('input[name="user[password_confirmation]"]').set('passwordd')
          click_button 'Update'
          expect(page).to have_content 'Password (confirmation) and password input do not match'
        end
      end
    end

    describe 'Display the flash message as per the conditions given in the requirement' do
      context 'If the account is successfully registered' do
        it 'To display a flash message "You have registered an account"' do
          visit new_user_path
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set('new_user@email.com')
          find('input[name="user[password]"]').set('new_password')
          find('input[name="user[password_confirmation]"]').set('new_password')
          click_button 'Register'
          expect(page).to have_content 'You have registered your account'
        end
      end
      context 'If the account is successfully updated' do
        before do
          visit new_session_path
          find('input[name="session[email]"]').set(user.email)
          find('input[name="session[password]"]').set(user.password)
          click_button 'Login'
        end
        it 'To display a flash message "You have updated your account"' do
          visit edit_user_path(user)
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set('new_user@email.com')
          find('input[name="user[password]"]').set('new_password')
          find('input[name="user[password_confirmation]"]').set('new_password')
          click_button 'Update'
          expect(page).to have_content 'You have updated your account'
        end
      end
      context 'If login was successful' do
        it 'To display a flash message "You are logged in"' do
          visit new_session_path
          find('input[name="session[email]"]').set(user.email)
          find('input[name="session[password]"]').set(user.password)
          click_button 'Login'
          expect(page).to have_content 'You are logged in'
        end
      end
      context 'Login failed' do
        it 'To display a flash message "You have an incorrect email address or password"' do
          visit new_session_path
          find('input[name="session[email]"]').set('failed_user@email.com')
          find('input[name="session[password]"]').set('failed_password')
          click_button 'Login'
          expect(page).to have_content 'You have an incorrect email address or password'
        end
      end
      context 'If you logged out' do
        before do
          visit new_session_path
          find('input[name="session[email]"]').set(user.email)
          find('input[name="session[password]"]').set(user.password)
          click_button 'Login'
        end
        it 'To display a flash message saying "You are logged out"' do
          click_link 'Logout'
          expect(page).to have_content 'You are logged out'
        end
      end
    end

    describe 'Create an association between a user and a task so that only tasks created by the user are displayed in the task list screen' do
      let!(:second_user) { User.create(name: 'second_user_name', email: 'second_user@email.com', password: 'password') }
      before do
        visit new_session_path
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button 'Login'
      end
      it 'To create an association between a user and a task, and to show only the tasks created by the user in the task list screen' do
        5.times do |n|
          Task.create(title: "task_title_#{n}", content: "task_content_#{n}", user_id: user.id)
          Task.create(title: "second_user_task_title_#{n}", content: "task_content_#{n}", user_id: second_user.id)
        end
        visit tasks_path
        5.times do |n|
          expect(page).to have_content "task_title_#{n}"
          expect(page).not_to have_content "second_user_task_title_#{n}"
        end
      end
    end

    describe 'If a user accesses a page other than the login screen and account registration screen without logging in, the user should be redirected to the login page and a flash message "Please login" should be displayed' do
      let!(:task){Task.create(title: 'task_title', content: 'task_content', user_id: user.id)}
      it 'If you access the task list screen' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'Please login'
      end
      it 'If you access the task registration screen' do
        visit new_task_path
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'Please login'
      end
      it 'If you access the task detail screen' do
        visit task_path(task)
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'Please login'
      end
      it 'If you access the task edit screen' do
        visit edit_task_path(task)
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'Please login'
      end
      it 'If you access the account detail screen' do
        visit user_path(user)
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'Please login'
      end
      it 'If you access the edit account page' do
        visit edit_user_path(user)
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'Please login'
      end
    end

    describe 'When an account is deleted, all tasks associated with that user will be deleted' do
      before do
        visit new_session_path
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button 'Login'
      end
      it 'When a user is deleted, all tasks associated with that user will be deleted' do
        10.times do
          Task.create(title: 'task_title', content: 'task_content', user_id: user.id)
        end
        visit user_path(user)
        click_link 'delete'
        page.driver.browser.switch_to.alert.accept
        sleep 0.5
        expect(Task.all.count).to eq 0
      end
    end
  end
end

RSpec.describe 'The default implementation of task management works fine', type: :system do

  let!(:user) { User.create(name: 'user_name', email: 'user@email.com', password: 'password') }
  let!(:task) { Task.create(title: 'task_title', content: 'task_content', user_id: user.id) }

  describe '* After the implementation of the login function is complete, make sure that all of the following items are satisfied.' do
    before do
      visit new_session_path
      find('input[name="session[email]"]').set(user.email)
      find('input[name="session[password]"]').set(user.password)
      click_button "Login"
    end
    describe 'screen transition' do
      it 'that the original path prefix can be used' do
        visit tasks_path
        visit new_task_path
        visit task_path(task)
        visit edit_task_path(task)
      end
    end

    describe 'screen design' do
      describe 'The original text, links, and buttons should appear on each screen' do
        it 'global navigation' do
          visit root_path
          expect(page).to have_link 'Task list' do
          expect(page).to have_link 'Register a task'
        end
        it 'task list screen' do
          visit tasks_path
          expect(page).to have_content 'Task List Page'
          expect(page).to have_content task.title
          expect(page).to have_content task.content
          expect(page).to have_link 'detail'
          expect(page).to have_link 'edit'
          expect(page).to have_link 'delete'
        end
        it 'task registration screen' do
          visit new_task_path
          expect(page).to have_content 'Task Registration Page'
          expect(page).to have_selector 'label', text: 'title'
          expect(page).to have_selector 'label', text: 'content'
          expect(page).to have_button 'Register'
          expect(page).to have_link 'Back'
        end
        it 'task detail screen' do
          visit task_path(task)
          expect(page).to have_content 'Task Detail Page' end
          expect(page).to have_content task.title
          expect(page).to have_content task.content
          expect(page).to have_link 'Edit'
          expect(page).to have_link 'Back'
        end
        it 'task edit screen' do
          visit edit_task_path(task)
          expect(page).to have_content 'Edit Task Page'
          expect(page).to have_selector 'label', text: 'title'
          expect(page).to have_selector 'label', text: 'content'
          expect(page).to have_button 'Update'
          expect(page).to have_link 'Back'
        end
      end
    end

    describe 'screen transition' do
      describe 'Successful screen transition' do
        it 'global navigation' do
          visit tasks_path
          click_link 'Register a task'
          expect(page).to have_content 'Register Task Page'
          click_link 'Task list'
          expect(page).to have_content 'Task List Page'
        end
        it 'When a task is registered, "Task List Page" will be displayed in the page title' do
          visit new_task_path
          fill_in 'title', with: 'task_title'
          fill_in 'content', with: 'task_content'
          click_button 'Register'
          expect(page).to have_content 'Task List Page'
        end
        it 'If you click "detail", the page title will show "Task Detail Page"' do
          visit tasks_path
          click_link 'detail'
          expect(page).to have_content 'Task Detail Page'
        end
        it 'When "Edit" is clicked, "Edit Task Page" will be displayed in the page title' do
          visit tasks_path
          click_link 'edit'
          expect(page).to have_content 'Edit Task Page'
        end
        it 'When "Refresh" is clicked, "Task List Page" will be displayed in the page title' do
          visit edit_task_path(task)
          click_button 'Update'
          expect(page).to have_content 'Task List Page'
        end
        it 'When "Delete" is clicked, "Task List Page" will be displayed in the page title' do
          visit tasks_path
          click_link 'delete'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'Task List Page'
        end
        it 'If you click "Back" on the registration page, "Task List Page" will be displayed in the page title' do
          visit new_task_path
          click_link 'Back'
          expect(page).to have_content 'Task List Page'
        end
        it 'If you click "Back" in the detail screen, "Task List Page" will be displayed in the page title' do
          visit task_path(task)
          click_link 'Back'
          expect(page).to have_content 'Task List Page'
        end
        it 'If you click "Back" in the edit screen, the page title will show "Task List Page"' do
          visit edit_task_path(task)
          click_link 'Back'
          expect(page).to have_content 'Task List Page'
        end
        it 'If task registration fails, "Task Registration Page" will be displayed in the page title' do
          visit new_task_path
          fill_in 'title', with: ''
          fill_in 'content', with: ''
          click_button 'Register'
          expect(page).to have_content 'Task Registration Page'
        end
        it 'If editing a task fails, "Edit Task Page" will be displayed in the page title' do
          visit edit_task_path(task)
          fill_in 'title', with: ''
          fill_in 'content', with: ''
          click_button 'Update'
          expect(page).to have_content 'Edit Task Page'
        end
      end
    end

    describe 'Functional requirements' do
      describe 'Confirmation Dialog' do
        it 'When you click on the link to delete a task, the confirmation dialog should say "Are you sure you want to delete it?" when clicking on a link to delete a task.' do
          visit tasks_path
          click_link 'delete'
          expect(page.driver.browser.switch_to.alert.text).to eq 'Are you sure you want to delete it?'
        end
      end
      describe 'validation message' do
        context 'Task Registration Screen' do
          it 'If the title is not entered, the validation message "Please enter a title" will be displayed.' do
            visit new_task_path
            fill_in 'title', with: ''
            fill_in 'content', with: ''
            click_button 'Register'
            expect(page).to have_content "Please enter a title"
          end
          it 'If the content has not been entered, a validation message "Please enter content" will be displayed.' do
            visit new_task_path
            fill_in 'title', with: ''
            fill_in 'content', with: ''
            click_button 'Register'
            expect(page).to have_content "Please fill in the content"
          end
          it 'If the title and content are not filled in, the validation message "Please enter a title" and "Please enter content" will be displayed.' do
            visit new_task_path
            fill_in 'title', with: ''
            fill_in 'content', with: ''
            click_button 'Register'
            expect(page).to have_content "Please enter a title"
            expect(page).to have_content "Please enter content"
          end
        end
        context 'Task edit screen' do
          it 'If the title has not been entered, the validation message "Please enter a title" will be displayed.' do
            visit edit_task_path(task)
            fill_in 'title', with: ''
            fill_in 'content', with: ''
            click_button 'Update'
            expect(page).to have_content "Please enter a title."
          end
          it 'If the content has not been entered, a validation message "Please enter content" will be displayed' do
            visit edit_task_path(task)
            fill_in 'title', with: ''
            fill_in 'content', with: ''
            click_button 'Update'
            expect(page).to have_content "Please enter content"
          end
          it 'If the title and content are not filled in, the validation message "Please enter title" and "Please enter content" will be displayed.' do
            visit edit_task_path(task)
            fill_in 'title', with: ''
            fill_in 'content', with: ''
            click_button 'Update'
            expect(page).to have_content "Please enter a title"
            expect(page).to have_content "Please enter the content"
          end
        end
      end
      describe 'flash message' do
        context 'When a task is successfully registered' do
          it 'To display a flash message "You have registered a task"' do
            visit new_task_path
            fill_in 'title', with: 'sample title'
            fill_in 'content', with: 'sample content'
            click_button 'Register'
            expect(page).to have_content "You have registered a task."
          end
        end
        context 'If the task was successfully updated' do
          it 'To display a flash message "The task has been updated"' do
            visit edit_task_path(task)
            fill_in 'title', with: 'update sample title'
            fill_in 'content', with: 'update sample content'
            click_button 'Update'
            expect(page).to have_content "You have updated the task."
          end
        end
        context 'Deleting a task' do
          it 'To display a flash message "Task has been deleted"' do
            visit tasks_path
            click_link 'delete'
            page.driver.browser.switch_to.alert.accept
            expect(page).to have_content "Task has been deleted"
          end
        end
      end
    end
  end
end
