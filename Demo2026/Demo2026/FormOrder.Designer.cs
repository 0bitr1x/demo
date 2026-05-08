namespace Demo2026
{
    partial class FormOrder
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            textBoxInn = new TextBox();
            textBoxName = new TextBox();
            textBoxKpp = new TextBox();
            textBoxPhone = new TextBox();
            textBoxEmail = new TextBox();
            textBoxDirector = new TextBox();
            textBoxAddress = new TextBox();
            textBoxPriority = new TextBox();
            comboBoxType = new ComboBox();
            pictureBox1 = new PictureBox();
            button1 = new Button();
            groupBox1 = new GroupBox();
            button3 = new Button();
            button2 = new Button();
            openFileDialog1 = new OpenFileDialog();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).BeginInit();
            groupBox1.SuspendLayout();
            SuspendLayout();
            // 
            // textBoxInn
            // 
            textBoxInn.Location = new Point(12, 12);
            textBoxInn.Name = "textBoxInn";
            textBoxInn.PlaceholderText = "Введите ИНН";
            textBoxInn.Size = new Size(296, 23);
            textBoxInn.TabIndex = 0;
            // 
            // textBoxName
            // 
            textBoxName.Location = new Point(12, 54);
            textBoxName.Name = "textBoxName";
            textBoxName.PlaceholderText = "Введите название";
            textBoxName.Size = new Size(296, 23);
            textBoxName.TabIndex = 1;
            // 
            // textBoxKpp
            // 
            textBoxKpp.Location = new Point(12, 99);
            textBoxKpp.Name = "textBoxKpp";
            textBoxKpp.PlaceholderText = "Введите КПП";
            textBoxKpp.Size = new Size(296, 23);
            textBoxKpp.TabIndex = 2;
            // 
            // textBoxPhone
            // 
            textBoxPhone.Location = new Point(12, 140);
            textBoxPhone.Name = "textBoxPhone";
            textBoxPhone.PlaceholderText = "Введите телефон";
            textBoxPhone.Size = new Size(296, 23);
            textBoxPhone.TabIndex = 3;
            // 
            // textBoxEmail
            // 
            textBoxEmail.Location = new Point(12, 187);
            textBoxEmail.Name = "textBoxEmail";
            textBoxEmail.PlaceholderText = "Введите Email";
            textBoxEmail.Size = new Size(296, 23);
            textBoxEmail.TabIndex = 4;
            // 
            // textBoxDirector
            // 
            textBoxDirector.Location = new Point(12, 233);
            textBoxDirector.Name = "textBoxDirector";
            textBoxDirector.PlaceholderText = "Введите ФИО директора";
            textBoxDirector.Size = new Size(296, 23);
            textBoxDirector.TabIndex = 5;
            // 
            // textBoxAddress
            // 
            textBoxAddress.Location = new Point(12, 285);
            textBoxAddress.Name = "textBoxAddress";
            textBoxAddress.PlaceholderText = "Введите адрес";
            textBoxAddress.Size = new Size(296, 23);
            textBoxAddress.TabIndex = 6;
            // 
            // textBoxPriority
            // 
            textBoxPriority.Location = new Point(165, 333);
            textBoxPriority.Name = "textBoxPriority";
            textBoxPriority.PlaceholderText = "Введите приоритет";
            textBoxPriority.Size = new Size(143, 23);
            textBoxPriority.TabIndex = 8;
            // 
            // comboBoxType
            // 
            comboBoxType.FormattingEnabled = true;
            comboBoxType.Location = new Point(12, 332);
            comboBoxType.Name = "comboBoxType";
            comboBoxType.Size = new Size(147, 23);
            comboBoxType.TabIndex = 13;
            // 
            // pictureBox1
            // 
            pictureBox1.Location = new Point(324, 15);
            pictureBox1.Name = "pictureBox1";
            pictureBox1.Size = new Size(303, 293);
            pictureBox1.SizeMode = PictureBoxSizeMode.StretchImage;
            pictureBox1.TabIndex = 10;
            pictureBox1.TabStop = false;
            // 
            // button1
            // 
            button1.Location = new Point(441, 332);
            button1.Name = "button1";
            button1.Size = new Size(75, 23);
            button1.TabIndex = 11;
            button1.Text = "Загрузить лого";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // groupBox1
            // 
            groupBox1.Controls.Add(button3);
            groupBox1.Controls.Add(button2);
            groupBox1.Location = new Point(337, 375);
            groupBox1.Name = "groupBox1";
            groupBox1.Size = new Size(290, 111);
            groupBox1.TabIndex = 12;
            groupBox1.TabStop = false;
            // 
            // button3
            // 
            button3.DialogResult = DialogResult.Cancel;
            button3.Location = new Point(151, 26);
            button3.Name = "button3";
            button3.Size = new Size(115, 64);
            button3.TabIndex = 1;
            button3.Text = "Отмена";
            button3.UseVisualStyleBackColor = true;
            // 
            // button2
            // 
            button2.DialogResult = DialogResult.OK;
            button2.Location = new Point(20, 26);
            button2.Name = "button2";
            button2.Size = new Size(111, 64);
            button2.TabIndex = 0;
            button2.Text = "Сохранить";
            button2.UseVisualStyleBackColor = true;
            // 
            // openFileDialog1
            // 
            openFileDialog1.FileName = "openFileDialog1";
            // 
            // FormOrder
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(639, 498);
            Controls.Add(comboBoxType);
            Controls.Add(groupBox1);
            Controls.Add(button1);
            Controls.Add(pictureBox1);
            Controls.Add(textBoxPriority);
            Controls.Add(textBoxAddress);
            Controls.Add(textBoxDirector);
            Controls.Add(textBoxEmail);
            Controls.Add(textBoxPhone);
            Controls.Add(textBoxKpp);
            Controls.Add(textBoxName);
            Controls.Add(textBoxInn);
            Name = "FormOrder";
            Text = "Редактирование агента";
            ((System.ComponentModel.ISupportInitialize)pictureBox1).EndInit();
            groupBox1.ResumeLayout(false);
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion
        private PictureBox pictureBox1;
        private Button button1;
        private GroupBox groupBox1;
        private Button button3;
        private Button button2;
        public TextBox textBoxInn;
        public TextBox textBoxName;
        public TextBox textBoxKpp;
        public TextBox textBoxPhone;
        public TextBox textBoxEmail;
        public TextBox textBoxDirector;
        public TextBox textBoxAddress;
        public ComboBox comboBoxType;
        public TextBox textBoxPriority;
        private OpenFileDialog openFileDialog1;
    }
}