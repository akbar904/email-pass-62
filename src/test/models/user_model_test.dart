
// test/models/user_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:your_project_name/models/user_model.dart';

void main() {
	group('UserModel', () {
		test('fromJson creates a UserModel from a JSON map', () {
			final json = {
				'id': '123',
				'email': 'test@example.com',
			};

			final user = UserModel.fromJson(json);

			expect(user.id, '123');
			expect(user.email, 'test@example.com');
		});

		test('toJson converts a UserModel to a JSON map', () {
			final user = UserModel(id: '123', email: 'test@example.com');

			final json = user.toJson();

			expect(json['id'], '123');
			expect(json['email'], 'test@example.com');
		});

		test('UserModel equality', () {
			final user1 = UserModel(id: '123', email: 'test@example.com');
			final user2 = UserModel(id: '123', email: 'test@example.com');
			final user3 = UserModel(id: '456', email: 'other@example.com');

			expect(user1, equals(user2));
			expect(user1, isNot(equals(user3)));
		});

		test('UserModel hash code', () {
			final user1 = UserModel(id: '123', email: 'test@example.com');
			final user2 = UserModel(id: '123', email: 'test@example.com');

			expect(user1.hashCode, equals(user2.hashCode));
		});
	});
}
